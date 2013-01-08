require 'boot'
module Vagrant
  module Provisioners
    class CopyMyConf < Base

      def prepare
        @to_be_copied = []
        config.all_true.each do |c|
          conf = self.class.const_get(c.capitalize).new
          @to_be_copied << conf
          conf.prepare env[:vm].config.vm, tmp_root
        end
      end

      def provision!
        channel = env[:vm].channel
        @to_be_copied.each do |conf|
          conf.provision channel, user_home, tmp_root
        end
        provision_ssh(channel) if config.ssh
        provision_vim(channel) if config.vim
        provision_git(channel) if config.git
      end

      def self.config_class
        Config
      end

    private

      def tmp_root
        "/tmp/copy_my_conf"
      end

      def prepare_ssh
        env[:vm].config.vm.share_folder("ssh", "#{tmp_root}/ssh", "~/.ssh")
      end

      def prepare_git
        `mkdir -p #{tmp_root}/git`
        `cp ~/.gitconfig #{tmp_root}/git/`
        env[:vm].config.vm.share_folder("git", "#{tmp_root}/git/", "#{tmp_root}/git")
      end

      def provision_git(channel)
        puts "Copying your gitconfig"
        channel.execute("cp #{tmp_root}/git/.gitconfig ~/")
      end

      def provision_ssh(channel)
        puts "Copying your ssh keys and config"
        channel.sudo("mkdir -p #{tmp_root}/cached && chown -R vagrant #{tmp_root}/cached")
        channel.execute("[[ -f #{user_home}/.ssh/authorized_keys ]] && mv #{user_home}/.ssh/authorized_keys #{tmp_root}/cached")
        channel.execute("cp #{tmp_root}/ssh/* #{user_home}/.ssh")
        channel.execute("cat #{tmp_root}/cached/authorized_keys >> #{user_home}/.ssh/authorized_keys") # So that `vagrant ssh` doesn't ask for password
      end

      def user_home
        config.user_home || "/home/vagrant"
      end
    end
  end
end
