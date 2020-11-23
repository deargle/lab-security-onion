# https://docs.securityonion.net/en/16.04/installing-on-ubuntu.html
# Configure MySQL not to prompt for root password (Setup will generate a random password later):

echo "debconf debconf/frontend select noninteractive" | sudo debconf-set-selections
#Clean apt list repository:

sudo rm -rf /var/lib/apt/lists/*
#Update package list:

sudo apt-get update
#Install software-properties-common if necessary:

sudo apt-get -y install software-properties-common
#Add the Security Onion stable repository:

sudo add-apt-repository -y ppa:securityonion/stable
#Update package list:

sudo apt-get update
#Install the securityonion-all metapackage:

sudo apt-get -y install securityonion-iso syslog-ng-core
#If you want to use Salt, then also install securityonion-onionsalt. You can do this before or after Setup, but it’s much easier if you do it before Setup.

#sudo apt -y install securityonion-onionsalt
#Run the Setup wizard (you can replace sosetup with sosetup-minimal if you prefer the minimal configuration):

#sudo sosetup
