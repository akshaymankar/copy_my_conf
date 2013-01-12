require "spec_helper"

module Vagrant
  module Provisioners
    describe CopyMyConf do
      before(:each) do
        env_vm = Object.new
        env_vm_config = Object.new
        @mock_vm = Object.new
        @config = CopyMyConf.config_class.new
        @env_channel = Object.new

        CopyMyConf.any_instance.stub(:env).and_return({:vm => env_vm})
        env_vm.stub(:config).and_return(env_vm_config)
        env_vm.stub(:channel).and_return(@env_channel)
        env_vm_config.stub(:vm).and_return(@mock_vm)
        CopyMyConf.any_instance.stub(:config).and_return(@config)
      end

      it "should prepare provisioning process" do
        @config.should_receive(:all_enabled_attributes).and_return([CopyMyConf::Vim.new])
        CopyMyConf::Vim.any_instance.should_receive(:prepare).with(@mock_vm, anything)

        CopyMyConf.new.prepare
      end

      it "should provision the vm" do
        @config.stub(:all_enabled_attributes).and_return([CopyMyConf::Vim.new])
        copy_my_conf = CopyMyConf.new

        CopyMyConf::Vim.any_instance.stub(:prepare)
        copy_my_conf.prepare

        CopyMyConf::Vim.any_instance.should_receive(:provision).with(@env_channel, anything, anything)
        copy_my_conf.provision!
      end
    end
  end
end
