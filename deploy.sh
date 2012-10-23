#!/bin/bash 

# Usage: ./deploy.sh [host]

# use the commandline argument 1 or if it's not there, use the ip specified here 
host="${1:-root@96.126.110.107}"

# removes old host from known_hosts in case host key changes when new VM instantiates
# parameter expansion removes anything in host variable before and including @
# any stderr is directed to /dev/null 
ssh-keygen -R "${host#*@}" 2> /dev/null 

# upload the public key to set up Public Key Authentication instead of PW Authentication
#ssh-copy-id "$host"

# creates an archive of the specified directory in bzip2 format
# pipe the output to tar in a string of command issued through ssh
# always confirm host key fingerprint during ssh 
tar cj ./chef/* | ssh -o 'StrictHostKeyChecking no' "$host" '
sudo rm -rf ~/chef && 
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
sudo bash chef/install.sh' 
