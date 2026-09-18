Vagrant.configure("2") do |config|

  config.vm.define "pip" do |pip|

    pip.vm.box = "bento/ubuntu-22.04"
    pip.vm.hostname = "vm-pipeline"
    pip.vm.network "private_network", ip: "192.168.100.11"

  end

end