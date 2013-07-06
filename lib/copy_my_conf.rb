module CopyMyConf
  class Plugin < Vagrant.plugin("2")
    name "copy_my_conf"

    config(:copy_my_conf, :provisioner) do
      require File.expand_path('../copy_my_conf/config', __FILE__)
      Config
    end

    provisioner :copy_my_conf do
      require File.expand_path('../copy_my_conf/provisioner', __FILE__)
      Provisioner
    end

  end
end
