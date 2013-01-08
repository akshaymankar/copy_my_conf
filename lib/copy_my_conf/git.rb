module Vagrant
  module Provisioners
    class CopyMyConf < Base
      class Git
        def prepare vm, tmp_root
          `mkdir -p #{tmp_root}/git`
          `cp ~/.gitconfig #{tmp_root}/git/`
          vm.share_folder("git", "#{tmp_root}/git/", "#{tmp_root}/git")
        end

        def provision channel, user_home, tmp_root
          puts "Copying your gitconfig"
          channel.execute("cp #{tmp_root}/git/.gitconfig #{user_home}")
        end
      end
    end
  end
end