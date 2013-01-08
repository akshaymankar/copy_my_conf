require "spec_helper"
module Vagrant::Provisioners
  class CopyMyConf < Base
    describe Config do
      it "should list all the true attributes" do
        config = Config.new

        config.vim = true
        config.ssh = true

        all_true_attributes = config.all_true
        all_true_attributes.should =~ [:vim, :ssh]
      end
    end
  end
end

