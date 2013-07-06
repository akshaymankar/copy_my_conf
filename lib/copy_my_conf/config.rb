require_relative "git"
require_relative "ssh"
require_relative "vim"

module CopyMyConf
  class Config < Vagrant.plugin("2", :config)
    attr_accessor :user_home

    def git
      @git ||= CopyMyConf::Git.new
    end

    def vim
      @vim ||= CopyMyConf::Vim.new
    end

    def ssh
      @ssh ||=CopyMyConf::Ssh.new
    end

    def all_enabled_attributes
      [@ssh, @vim, @git].compact
    end
  end
end

