module Vagrant
  module Provisioners
    class CopyMyConf < Base
      class Config < Vagrant::Config::Base
        def self.all_attributes
          [:ssh, :vim, :git]
        end
        attr_accessor :user_home

        all_attributes.each do |attr|
          define_method(attr) do
            instance_variable_get_or_set(attr, CopyMyConf.const_get("#{attr.capitalize}").new)
          end
        end

        def all_enabled_attributes
          all_attributes.collect do |attr|
            instance_variable_get "@#{attr}"
          end.compact
          [@ssh, @vim, @git].compact
        end

      private
        def all_attributes
          self.class.all_attributes
        end

        def instance_variable_get_or_set(attr, value)
          instance_variable_get("@#{attr}") || instance_variable_set("@#{attr}", value)
        end
      end
    end
  end
end

