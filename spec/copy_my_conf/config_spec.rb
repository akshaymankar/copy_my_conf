require "spec_helper"
module Vagrant::Provisioners
  class CopyMyConf < Base
    describe Config do
      it "should list all the true attributes" do
        config = Config.new

        config.vim
        config.ssh

        all_enabled_attributes = config.all_enabled_attributes
        all_enabled_attributes.map(&:class) =~ [Vim, Ssh]
      end
    end
  end
end

