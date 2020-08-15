# lab-security-onion
for my infosec class


This is the vagrantfile that I need to bundle (sans the box line)
```
Vagrant.configure("2") do |config|

  config.vm.box = "deargle/security-onion"
  
  config.vm.provider :libvirt do |libvirt, override|
    libvirt.disk_bus       = "virtio"
    libvirt.driver         = "kvm"
    libvirt.graphics_type  = "spice"
    libvirt.memory         = 8192
    libvirt.nic_model_type = "virtio"
    libvirt.sound_type     = "ich6"
    libvirt.video_type     = "virtio"
    libvirt.cpus           = 2

    libvirt.channel :type  => 'spicevmc', :target_name => 'com.redhat.spice.0',     :target_type => 'virtio'
    libvirt.channel :type  => 'unix',     :target_name => 'org.qemu.guest_agent.0', :target_type => 'virtio'
    libvirt.random  :model => 'random'
  end

  config.vm.network :private_network,
    ip: "192.168.56.254", #ip doesn't matter, security-onion configures eth1 to be a sniffing interface
    auto_config: false

  # Disable NFS sharing (==> default: Mounting NFS shared folders...)
  config.vm.synced_folder ".", "/vagrant", type: "nfs", disabled: true
  
end
```
# to package
vagrant-libvirt uses sysprep, which needs some special settings, use `package.sh` to package the vagrant box.
