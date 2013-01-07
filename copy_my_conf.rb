class CopyMyConf < Vagrant::Provisioners::Base

  def prepare
    prepare_vim if config.vim
    prepare_git if config.git
    prepare_ssh if config.ssh
  end

  def provision!
    channel = env[:vm].channel
    provision_ssh(channel) if config.ssh
    provision_vim(channel) if config.vim
    provision_git(channel) if config.git
  end

  def self.config_class
    Config
  end

  class Config < Vagrant::Config::Base
    attr_accessor :ssh
    attr_accessor :vim
    attr_accessor :git
    attr_accessor :user_home
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

  def prepare_vim
    `mkdir -p #{tmp_root}/vim`
    ["~/.vimrc", "~/.vim"].each do |file|
      `cp -r #{file} #{tmp_root}/vim`
    end
    env[:vm].config.vm.share_folder("vim", "#{tmp_root}/vim/", "#{tmp_root}/vim")
  end

  def provision_git(channel)
    puts "Copying your gitconfig"
    channel.execute("cp #{tmp_root}/git/.gitconfig ~/")
  end

  def provision_vim(channel)
    puts "Copying your vim configuratios"
    channel.execute("rm -rf #{user_home}/.vim*")
    channel.execute("cp -r #{tmp_root}/vim/.??* ~/")
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
