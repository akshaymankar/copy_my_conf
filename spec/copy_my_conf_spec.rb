require "spec_helper"

module Vagrant
  module Provisioners
    describe CopyMyConf do
      xit "should prepare provisioning process" do
        copy_my_conf = CopyMyConf.new

        config = CopyMyConf.config_class.new
        config.vim = true

        copy_my_conf.stub(:config).and_return(config)

        CopyMyConf::Vim.any_instance.should_receive(:prepare)
      end
    end
  end
end
