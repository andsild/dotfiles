#!/usr/bin/env bash

sudo systemctl stop clamav-daemon.service 
sudo systemctl stop collectd.service 
sudo systemctl stop cups.service 
sudo systemctl stop display-manager.service 
sudo systemctl stop docker.service 
sudo systemctl stop docker.socket 
sudo systemctl stop phpfpm-pool1.service 
sudo systemctl stop phpfpm.slice 
sudo systemctl stop phpfpm.target 
