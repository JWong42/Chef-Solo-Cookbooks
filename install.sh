#!/usr/bin/env bash

apt-get -y update
apt-get -y upgrade 

apt-get -y install ruby1.9.1 build-essential 
gem install chef --no-rdoc --no-ri 
