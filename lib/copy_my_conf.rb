require 'boot'
module Vagrant
  module Provisioners
    class CopyMyConf < Base
      def initialize *args
        `rm -rf /tmp/copy_my_conf`
        super *args
      end

      def prepare
        @to_be_copied = []
        config.all_enabled_attributes.each do |conf|
          @to_be_copied << conf
          conf.prepare env[:vm].config.vm, tmp_root
        end
      end

      def provision!
        channel = env[:vm].channel
        @to_be_copied.each do |conf|
          conf.provision channel, user_home, tmp_root
        end
      end

      def self.config_class
        Config
      end

    private

      def tmp_root
        "/tmp/copy_my_conf"
      end

      def user_home
        config.user_home || "/home/vagrant"
      end
    end
  end
end
