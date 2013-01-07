# CopyMyConf

Now you can copy your dotfiles into your vagrant box, so that you don't feel like visiting Mars whenever you are in vagrant shell.

## How to Use

It is a simple 3 step process

### Add gem in your vagrant

    $ vagrant gem install copy_my_conf

### Add provisioner in your Vagrantfile

Add these lines in your vagrant file inside the `Vagrant::Config.run` block

    config.vm.provision CopyMyConf do |copy_conf|
      copy_conf.git = true
      copy_conf.vim = true
      copy_conf.ssh = true
    end

Don't worry if you have any other provisioners, vagrant can work with multiple provisioners. Yay \o/  
As you might have guessed, If you make any of these false, the corresponding files won't be copied

If home directory of the user is not `/home/vagrant` then you can specify that using the `user_home` option in above code

      copy_conf.user_home = '/home/some_other_user'

### Fire !

    $ vagrant up

And you'll be good to go.

## Feedback
This is my first gem so any kind of feedback would be appreciated.  
Feel free fork, edit and send pull requests.

## Copyrights & Author

Copyright(c) 2013 Akshay Mankar <itsakshaymankar@gmail.com>  
License: [MIT License](http://mit-license.org/)
