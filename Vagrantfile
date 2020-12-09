Vagrant.configure("2") do |config|

  config.vm.box = "deargle/security-onion"

  config.vm.provider "libvirt" do |libvirt|
    libvirt.management_network_name = 'infosec-vagrant-libvirt'
    libvirt.management_network_autostart = true
  end

end
