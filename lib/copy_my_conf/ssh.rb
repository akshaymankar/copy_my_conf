module Vagrant
  module Provisioners
    class CopyMyConf < Base
      class Ssh
        def prepare vm, tmp_root
          vm.share_folder("ssh", "#{tmp_root}/ssh", "~/.ssh")
        end

        def provision channel, user_home, tmp_root
          puts "Copying your ssh keys and config"
          channel.sudo("mkdir -p #{tmp_root}/cached && chown -R vagrant #{tmp_root}/cached")
          channel.execute("[[ -f #{user_home}/.ssh/authorized_keys ]] && mv #{user_home}/.ssh/authorized_keys #{tmp_root}/cached")
          channel.execute("cp #{tmp_root}/ssh/* #{user_home}/.ssh")
          channel.execute("cat #{tmp_root}/cached/authorized_keys >> #{user_home}/.ssh/authorized_keys") # So that `vagrant ssh` doesn't ask for password
        end

      end
    end
  end
end
