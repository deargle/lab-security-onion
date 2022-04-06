Vagrant.configure("2") do |config|

  config.vm.box = "deargle/security-onion"
  config.ssh.insert_key = false

  config.vm.provider "libvirt" do |libvirt|
    libvirt.management_network_name = 'vagrant-libvirt'
    libvirt.management_network_autostart = true
  end

  config.vm.provision "shell", path: "build/scripts/download-casefiles.sh"


end
