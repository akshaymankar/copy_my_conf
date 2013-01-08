module Vagrant
  module Provisioners
    class CopyMyConf < Base
      class Config < Vagrant::Config::Base
        def self.all_attributes
          [:ssh, :vim, :git]
        end
        attr_accessor *all_attributes
        attr_accessor :user_home

        def all_true
          self.class.all_attributes.collect do |attr|
            self.send(attr) ? attr : nil
          end.compact
        end
      end
    end
  end
end

