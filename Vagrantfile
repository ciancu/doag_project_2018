require 'getoptlong'

opts = GetoptLong.new(
  [ '--action', GetoptLong::OPTIONAL_ARGUMENT ],
  [ '--apex-version', GetoptLong::OPTIONAL_ARGUMENT ]
)

actionArg=''
apexVersionArg=''

opts.each do |opt, arg|
  case opt
    when '--action'
      actionArg=arg
	when '--apex-version'
      apexVersionArg=arg
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ol73"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
   config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  ###########
  #Oracle DB port
   config.vm.network "forwarded_port", guest: 1521, host: 1522
  #Oracle APEX Port 
   config.vm.network "forwarded_port", guest: 8080, host: 8080
  #Openldap ports 
   config.vm.network "forwarded_port", guest: 389, host: 389
   config.vm.network "forwarded_port", guest: 636, host: 636
   config.vm.network "forwarded_port", guest: 639, host: 639
  # Keyclock
   config.vm.network "forwarded_port", guest: 9080, host: 9080
   config.vm.network "forwarded_port", guest: 9443, host: 9443
   config.vm.network "forwarded_port", guest: 10990, host: 10990

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
     vb.gui = false
     file_to_disk = 'doag_infra_storage.vdi'
     unless File.exist?(file_to_disk)
       vb.customize ['createhd', '--filename', file_to_disk, '--size', 200 * 1024]
     end
     vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
  #   # Customize the amount of memory on the VM:
     vb.memory = "8192"
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
	config.vm.provision "shell",run:"always", inline: <<-SHELL
       echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhV241bZrSenJuHYZqpR0f4tIUEoO9QQ43Y8RvpqR7egKjDcRIz3RwLwYRqV3SlM7hynzvEfttooqRhvw8BcMnytCGsQsInZ2dk0Pya6LZ0RitIBSX2pRj2L7SzZMcbeEdOGjNq5V98Exet6Jv5ag1Z+FM1CVSiLX0MMBYfD64qeDsx2IP78dQ/MFzfXEwsL8x2OkrfAns0c4z42gpWeIPC/tc7XVa/vxQEQYL6UMcmUxKBxGqh4NkrJj8DK512coR/VPL1sEa0CWRe3GCiy5wzijT6/KW8dnCe6Dc9SJqnhmQig3Q0OKqshn4lgkbazFGUIJUhBJPFWH6Kia/sskPw== rsa-key-20170426" >> /home/vagrant/.ssh/authorized_keys

install_docker(){
    echo "Install docker!"
    cat <<-'      EOF' > /etc/yum.repos.d/public-yum-ol7.repo
      [ol7_latest]
      name=Oracle Linux $releasever Latest (x86_64)
      baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/
      gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
      gpgcheck=1
      enabled=1
      [ol7_addons]
      name=Oracle Linux $releasever Add ons (x86_64)
      baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/addons/x86_64/
      gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
      gpgcheck=1
      enabled=1
      EOF
    sed "s/^[ \t]*//" -i /etc/yum.repos.d/public-yum-ol7.repo
    yum makecache fast
    #install docker
    yum install -y docker-engine
    yum install -y zip
	yum install -y unzip
    yum clean all
    #disable SELINUX
    setenforce 0
    sed -i 's/SELINUX=\(enforcing\|permissive\)/SELINUX=disabled/g' /etc/selinux/config
    #configure docker storage
    pvcreate /dev/sdb
    vgcreate docker /dev/sdb
    lvcreate --wipesignatures y -n thinpool docker -l 95%VG
    lvcreate --wipesignatures y -n thinpoolmeta docker -l 1%VG
    lvconvert -y --zero n -c 512K --thinpool docker/thinpool --poolmetadata docker/thinpoolmeta
    echo -e "activation {\n  thin_pool_autoextend_threshold=80\n  thin_pool_autoextend_percent=20\n}" > /etc/lvm/profile/docker-thinpool.profile
    lvchange --metadataprofile docker-thinpool docker/thinpool
    lvs -o+seg_monitor
    mkdir /etc/docker
    touch /etc/docker/daemon.json
    echo -e '{\n "storage-driver": "devicemapper",\n "insecure-registries" : ["kubtm02.virtual7.local:5000"],\n "storage-opts": [\n "dm.thinpooldev=/dev/mapper/docker-thinpool",\n "dm.use_deferred_removal=true",\n "dm.use_deferred_deletion=true"\n ]\n}' > /etc/docker/daemon.json
    sed -e '/^DOCKER_STORAGE_OPTIONS/ s/^#*/#/' -i /etc/sysconfig/docker-storage
	echo "192.168.1.52 kubtm02.virtual7.local" >> /etc/hosts
    #start docker
    systemctl enable docker
    systemctl start docker
    #Docker compose
    curl -L https://github.com/docker/compose/releases/download/1.21.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose 
    cp /usr/local/bin/docker-compose /usr/local/sbin/ 
    chmod +x /usr/local/bin/docker-compose 
    chmod +x /usr/local/sbin/docker-compose
    docker-compose --version
}
       
install_db(){
    echo "Install database!"
    #Create Oracle DB instance
    docker volume create oracle_data
    docker run -d --name doag_database -p 8080:8080 -p 1521:1521 --link docker_keycloak_1:keycloak --net docker_default -v oracle_data:/u01/app/oracle -e CHARACTER_SET=AL32UTF8 sath89/oracle-12c
    docker run -e TARGETS=172.17.0.2:8080 -e TIMEOUT=3600 waisbrot/wait
}
install_keycloak(){
    echo "Install keycloak!"
    #Keycloak
    docker-compose -f /vagrant/docker/keycloak.yml up -d
}
       
install_apex(){
    echo "Install apex, version:#{apexVersionArg}!"
 
    #Upgrade APEX for the Oracle Database(in case decision is done to use APEX for Administration)
    cd /vagrant
    #wget https://github.com/ciancu/docker-oracle-apex/archive/#{apexVersionArg}.zip
    unzip #{apexVersionArg}.zip
    cd docker-oracle-apex-#{apexVersionArg}
    docker build -t apex:#{apexVersionArg} .
    echo "Done with DB, is time to upgrade APEX, this will take some time, take a cofee ..."
    docker run --rm --volumes-from doag_database --link doag_database:oracle-database --net docker_default -e PASS=oracle apex:#{apexVersionArg} install
    #rm -f /vagrant/#{apexVersionArg}.zip
    rm -rf /vagrant/docker-oracle-apex-#{apexVersionArg}
}
       
install_application(){
    #Create and Import database schemas
    cd /vagrant
    zip -r v7-database-install/scripts.zip scripts
    zip -r v7-database-install/dumps.zip dumps
    zip -r v7-database-install/certs.zip certs
    cd /vagrant/v7-database-install
    docker build -t v7-database-install .
    docker run --rm --volumes-from doag_database --link doag_database:oracle-database --net docker_default -e PASS=oracle v7-database-install install
}

echo 'Run provisioning with parameter: #{actionArg}'
case '#{actionArg}' in
 'install_docker')
	  install_docker
	  ;;
 'install')
	  install_docker
	  install_keycloak
	  install_db
	  install_apex
	  install_application
	  ;;
 'upgrade_app')
	  install_application
	  ;;
 'upgrade_apex')
	  install_apex
	  ;;
esac       

  SHELL

end
