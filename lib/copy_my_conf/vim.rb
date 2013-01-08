module Vagrant
  module Provisioners
    class CopyMyConf < Base
      class Vim
        def prepare vm, tmp_root
          `mkdir -p #{tmp_root}/vim`
          ["~/.vimrc", "~/.vim"].each do |file|
            `cp -r #{file} #{tmp_root}/vim`
          end
          vm.share_folder("vim", "#{tmp_root}/vim", "#{tmp_root}/vim")
        end

        def provision channel, user_home, tmp_root
          puts "Copying your vim configuratios"
          channel.execute("rm -rf #{user_home}/.vim*")
          channel.execute("cp -r #{tmp_root}/vim/.??* ~/")
        end
      end
    end
  end
end
