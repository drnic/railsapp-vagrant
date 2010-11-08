# Sample Rails3, Vagrantfile and testing within Hudson CI

This README describes how to start up a Hudson CI server, create a VM and add it to Hudson CI server as a slave, and create/build a job to run this project's tests. 

<img src="http://img.skitch.com/20101108-jpitj3arquqthqndhs4eagmy89.png">

This app has a Vagrantfile and Chef recipes to create a VirtualBox VM ready for integration testing.

It includes a Java JRE so that [Hudson CI](http://hudson-ci.org/) can use the VM as a slave node, SSH into it, inject its slave.jar and automated it.

## Preparation

For the tutorial on running CI tests through Hudson CI with VM instances constructed by Vagrant, there are a couple preparation steps:

    git clone git://github.com/drnic/railsapp-vagrant.git
    cd railsapp-vagrant

Next, install [VirtualBox](http://virtualbox.org/).

## Vagrant

Install [Vagrant](http://vagrantup.com/) and download the Ubuntu Lucid 32bit VirtualBox image:

    gem install vagrant -v 0.6.7 # if other version, the replace '0.6.7' in instructions below
    vagrant box add base http://files.vagrantup.com/lucid32.box

Then to spin up a VM for this Rails app (takes 10 minutes, mostly due to installing Java JRE, I think):

    vagrant init base
    vagrant up

To access this project within the VM:

    vagrant ssh
    $ cd /vagrant/
    $ rake test
    /vagrant/db/schema.rb doesn't exist yet.

## Quick fix of VM

When I do this the `~/.gem` folder is owned by `root` and not the `vagrant` user. This isn't correct. Fix it within the VM:

    $ sudo chown vagrant:vagrant ~/.gem
    $ exit

## Testing within Hudson CI

You can add this VM into Hudson CI as a slave, create a Hudson job for this project, and restrict it to running the tests only within this VM. This will ensure that you have all the system/utility/ruby requirements for your tests. Ideally, these will match your production deployment environment.

To experiment with Hudson CI:

    gem install hudson
    hudson server

This spins up Hudson CI at http://localhost:3010. 

In another terminal, add the VM as a slave node:

    $ hudson add_node localhost --name "VM" \
        --label railsapp-vagrant \
        --slave-port 2222 \
        --slave-user vagrant \
        --slave-fs /vagrant/tmp/hudson-slave \
        --master-key /Library/Ruby/Gems/1.8/gems/vagrant-0.6.7/keys/vagrant \
        --host localhost --port 3010
    
    $ hudson nodes --host localhost --port 3001
    master
    VM
    
Visit your Hudson CI to see the Slave node registered as "VM" on the left hand side.

To add this Rails3 application as a CI job in Hudson:

    hudson create . --template rails3 --assigned-node railsapp-vagrant

Note: the `--host` and `--port` flags are only required when you want the `hudson` CLI to change/set which Hudson CI master it is communicating with. Well, that's how the CLI works at the time of writing.

Visit your Hudson CI and see a new job in the list and it should start building automatically. Click through and find the Output Log to see the build in progress. It should end up with `SUCCESS`!

<img src="http://img.skitch.com/20101108-jpitj3arquqthqndhs4eagmy89.png">

<img src="http://img.skitch.com/20101108-f4ndidacj2cjxy249nbd82sjg6.png">
