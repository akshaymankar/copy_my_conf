require "spec_helper"

module Vagrant
  module Provisioners
    class CopyMyConf < Base
      describe Vim do
        it "should copy dotfiles to temporary location in vagrant box" do
          Vim.any_instance.stub(:`).and_return(nil)
          vm = Object.new
          tmp_root = "tmp_root"

          vm.should_receive(:share_folder).with(anything, "#{tmp_root}/vim", "#{tmp_root}/vim")
          vim = Vim.new

          vim.prepare vm, tmp_root
        end
      end
    end
  end
end