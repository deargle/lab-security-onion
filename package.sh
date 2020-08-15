#!/bin/bash
vagrant provision --provision-with sysprep
vagrant halt
export VAGRANT_LIBVIRT_VIRT_SYSPREP_OPERATIONS="defaults,-ssh-userdir,-ssh-hostkeys,-lvm-uuids"
vagrant package --output package.box #--vagrantfile vagrantfile-template.template
# vagrant cloud publish...
