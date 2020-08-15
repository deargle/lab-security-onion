# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "deargle/ubuntu-16.04-desktop-amd64"
  
  config.vm.provider :libvirt do |libvirt, override|
    libvirt.disk_bus       = "virtio"
    libvirt.driver         = "kvm"
    libvirt.graphics_type  = "spice"
    libvirt.memory         = 8192
    libvirt.nic_model_type = "virtio"
    libvirt.sound_type     = "ich6"
    libvirt.video_type     = "virtio"
    libvirt.video_vram      = nil
    libvirt.cpus           = 2

    libvirt.channel :type  => 'spicevmc', :target_name => 'com.redhat.spice.0',     :target_type => 'virtio'
    libvirt.channel :type  => 'unix',     :target_name => 'org.qemu.guest_agent.0', :target_type => 'virtio'
    libvirt.random  :model => 'random'
  end

  config.vm.network :private_network,
    ip: "192.168.56.254", #ip doesn't matter, security-onion configures eth1 to be a sniffing interface
    auto_config: false
  
  config.ssh.insert_key = false

  # Disable NFS sharing (==> default: Mounting NFS shared folders...)
  config.vm.synced_folder ".", "/vagrant", type: "nfs", disabled: true
  
  config.vm.provision "shell", path: "scripts/network-interfaces.sh"
  config.vm.provision "shell", path: "scripts/install-security-onion.sh"
  config.vm.provision "file", source: "sosetup.conf", destination: "~/sosetup.conf"
  config.vm.provision "shell", inline: "sudo sosetup -y -f sosetup.conf"
  config.vm.provision "shell", path: "scripts/sosetup-minimal-tune.sh"
  config.vm.provision "shell", path: "scripts/create-securityonion-user.sh"
  config.vm.provision "shell", path: "scripts/autologin-securityonion.sh"
  config.vm.provision "shell", path: "scripts/disable-automatic-updates.sh"
  config.vm.provision "shell", path: "scripts/disable-timeout.sh"
  config.vm.provision "shell", path: "scripts/copy-vagrant-desktop.sh"

  config.vm.provision "shell", path: "scripts/install-silk.sh"
  config.vm.provision "shell", path: "scripts/set-silk-envvar.sh"
  config.vm.provision "shell", path: "scripts/download-casefiles.sh"
  config.vm.provision "shell", path: "scripts/fix-pork-rules.sh"
  
end
