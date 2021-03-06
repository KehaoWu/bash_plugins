#!/bin/bash

## Docker CE installation on ubuntu.

sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
       
sudo apt-key fingerprint 0EBFCD88
    
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 7EA0A9C3F273FCD8 

    
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
