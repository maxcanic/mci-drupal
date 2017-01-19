#!/usr/bin/env bash
# MacMladen (C) 2016 macmladen@gmail.com @macmladen
# Version: 1.0
# Date: 2016-12-19
# Description: Commands to install docker on server, VPS or barebone, should
#     not be used as script, more like a recorded history of needed steps
# TODO: User/group 82 is actually PHP/drush user from wodby/drupal-php, not ideal because it is hard-coded

echo "
####----------------------------------------------------------------------------
##
##                            A L E R T !
##
##               This looks like a script but actually it is
##               commented history, should not be run as script
##               but followed as instruction on how to do it
##               see inside script for details and comments.
##
####----------------------------------------------------------------------------
"
exit 1

#
# This was run on VPS Ubuntu 16.04 from VPS.ovh.ca
#

####----------------------------------------------------------------------------
##                    Preparing system for installation
####
## Make usual stuff in shell
# Force color terminal, change prompt to "\[\033[1;34m\]\w\n\[\033[0;32m\]\u@\033[90m\]\h\[\033[0m\] \t $ "
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;34m\]\w\n\[\033[0;32m\]\u@\033[90m\]\h\[\033[0m\] \t $ '
nano .bashrc
# MacMladen aliases
#  alias ..='cd ..'
#  alias ...='cd ../..'
#
#  alias df='df -kTh'
#
#  alias md='mkdir -p'
#  alias rd='rmdir'
#
#  alias untar='tar xf'
#  alias wget='wget --no-check-certificate'
nano .bash_aliases
. .bashrc
. .bash_aliases

# Lets put in keys
nano .ssh/authorized_keys
ssh-keygen -t rsa -b 4096

# This is not strictly needed as Docker does it all
# Alwyas, before anything, refresh the system!
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

# What is running, stop/remove everything unneeded
service --status-all

# Favourite tools
apt-get install curl htop mc

####----------------------------------------------------------------------------
##
##                            A L E R T !
##
##               Use just one, Nicer or Better way
##
####----------------------------------------------------------------------------

####----------------------------------------------------------------------------
##                    Nicer way to install docker
####
# We need to add docker key and repository
apt-get install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list

# Now we have to refresh with new sources from docker
apt-get update
# This is just a check, should give some info
apt-cache policy docker-engine

# Now we are ready to install docker
apt-get install docker-engine
# Check if docker service is up, but last line after installing should show it is started
docker -v
ps aux | grep -i docker

# In case you need to start or stop use this
#   service docker start
#   service docker stop

####--------- END nicer way to install docker ----------------------------------

####----------------------------------------------------------------------------
## Probably the best way to install docker on server, maybe too aggressive
## as it change kernel and do some things without asking
####
# Docker installer that also fixes kernel
curl -sSL https://get.docker.com/ | sh
# Add swapaccount=1 to GRUB_CMDLINE_LINUX
nano /etc/default/grub
update-grub
uname -r
reboot

# Now it is needed because of new kernel
apt update
apt upgrade -y

####--------- END Better way to install docker ----------------------------------

####----------------------------------------------------------------------------
##                    Check system for Docker compliance
####
# Check system
uname -a
# There should be no warning at the end
docker info
# This will produce warning on swap, some rt and zfs but it is OK
wget https://raw.githubusercontent.com/docker/docker/master/contrib/check-config.sh
chmod +x check-config.sh
./check-config.sh

####----------------------------------------------------------------------------
##                        Install docker-composer
##       check which is latest at https://github.com/docker/compose/releases/
####
curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

####----------------------------------------------------------------------------
##                        Docker as non-login user
####
# User and group fix
groupmod -g 82 docker
useradd -u 82 -g 82 -m -s /usr/sbin/nologin docker
service docker restart

####----------------------------------------------------------------------------
##                         Rancher server, agent
####
# Starting Rancher-server docker
docker run -d -v /data/rancher/mysql:/var/lib/mysql --restart=unless-stopped -p 8080:8080  --name rancher-server rancher/server
# Starting Rancher-agent docker (generated by Rancher server add host)
# docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.1.0 http://maxdev.dx.rs:8080/v1/scripts/778805E63B7EF4F0CB25:1480676400000:3q3VLvnMjnQGZtAUwRyPJKPKnFU

####----------------------------------------------------------------------------
##                           Get our dc tool
####
cd /opt/
# We need a key in Gilab first
cat ~/.ssh/id_rsa.pub
git clone git@gitlab.com:MacMladen/dc.git

####----------------------------------------------------------------------------
##                          Working structure
####
# Our working directory structure
mkdir -p /data/{projects,proxy,archive,rancher}
chown -R docker:docker /data
