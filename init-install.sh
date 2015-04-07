#! /bin/bash
HOST_OS_VERSION=`cat /etc/lsb-release | grep DISTRIB_RELEASE | cut -d= -f2`
echo "HOST_OS_VERSION is $HOST_OS_VERSION"

if [ "$HOST_OS_VERSION" != "14.04" ]; then
  echo "This init-install script is just for Ubuntu 14.04"
  exit 1
fi

command_exists()
{
	command -v "$@" > /dev/null 2>&1
}

install_stow()
{
	if command_exists stow; then
		echo "stow has installed"
		return 0
	fi

	echo "===== Start to install Stow"
	sudo apt-get install -y -q stow
}

# Install VirtualBox
install_vbox()
{
	if command_exists virtulbox; then
		echo "Virtulbox has installed"
		return 0
	fi

	echo "===== Start to install VirtualBox"

	sudo echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list  
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install -y -q virtualbox-4.3
}

# Install Emacs
EMACS_VER=24.4
install_emacs()
{
	if command_exists emacs; then
		echo "Emacs has installed"
		return 0
	fi

	echo "===== Start to install Emacs"
	# Clone my emacs configurations
	if [ ! -d $HOME/.emacs.d ]; then
		echo "===== Download emacs configurations"
		git clone https://github.com/edunonnn/emacs.d $HOME/.emacs.d -b develop
	fi

	if ! command_exists stow; then
		install_stow
	fi

        echo "===== Download Emacs tarball"
	#wget http://ftp.twaren.net/Unix/GNU/gnu/emacs/emacs-$EMACS_VER.tar.gz -P /tmp

        echo "===== Extract Emacs tarball"
	#tar zxfv /tmp/emacs-$EMACS_VER.tar.gz -C /tmp

        echo "===== Compile Emacs source"
	/tmp/emacs-$EMACS_VER/configure
	
}

install_emacs


