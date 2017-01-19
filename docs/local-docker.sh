#!/usr/bin/env bash
# MacMladen (C) 2016 macmladen@gmail.com @macmladen
# Version: 1.0
# Date: 2016-12-19
# Description: Commands to install docker on local development machine, should
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

####----------------------------------------------------------------------------
##                    For new, freash system install,
##                     MacMladen opinionated settings
####
## Make usual stuff in shell
# Force color terminal, change prompt to "\[\033[1;34m\]\w\n\[\033[0;32m\]\u@\033[90m\]\h\[\033[0m\] \t $ "
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
ssh-keygen -t rsa -b 4096

# This is not strictly needed as Docker does it all
# Alwyas, before anything, refresh the system!
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# What is running, stop/remove everything unneeded
sudo service --status-all

# Favourite tools
sudo apt-get install curl htop mc

####----------------------------------------------------------------------------
##                    Nicer way to install docker
####
# We need to add docker key and repository
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list

# Now we have to refresh with new sources from docker
sudo apt-get update
# This is just a check, should give some info
sudo apt-cache policy docker-engine

# Now we are ready to install docker
sudo apt-get install docker-engine
# Check if docker service is up, but last line after installing should show it is started
docker -v
ps aux | grep -i docker

# In case you need to start or stop use this
#   sudo service docker start
#   sudo service docker stop

####--------- END nicer way to install docker ----------------------------------

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
sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Being in Linux we need some few more bits
# First we need to be a part of the group to run docker without sudo
# In case group is not there:
#     sudo groupadd docker
sudo gpasswd -a ${USER} docker

# Our docker user to run containers
sudo useradd -r -s /bin/false -g docker docker

# Definitive chech docker is working
docker run hello-world
# should print some info about dovker

####----------------------------------------------------------------------------
##                           Some docker commands
####
# List locally available docker images
docker images
# Check all docker processes
docker ps
# Interactive docker statistics
docker stats
# Non-interactive docker statistics
docker stats --no-stream
# Starting docker containers based on docker-compose.yml and stay in foreground
docker-compose up
# Start like previous but demonize (go to background)
docker-compose up -d

####----------------------------------------------------------------------------
##                         Make all sites in ~/Sites
####
# For all sites
mkdir ~/Sites

####----------------------------------------------------------------------------
##      Serious Drupal development requires drush, composer and drupal-console
####
# drush
sudo curl -L https://github.com/drush-ops/drush/releases/download/8.1.3/drush.phar -o /usr/local/bin/drush
# Make it executable
sudo chmod +x /usr/local/bin/drush
# check it
drush st
# add bash completition
drush init
