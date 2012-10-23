#!/usr/bin/env bash

chef_binary=/usr/local/bin/chef-solo

if ! [ -f "$chef_binary" ]; then

  apt-get -y update
  apt-get -y upgrade 

  apt-get -y install ruby1.9.1 build-essential 
  gem install chef --no-rdoc --no-ri 

fi 

