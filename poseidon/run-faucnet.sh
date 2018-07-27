#!/bin/bash

# PREREQUISITS...
# ~/workspace/faucet/
# ~/workspace/docker-mininet
# ~/workspace/traffic
# docker
# docker-compose
# xhost

# Grab local IP address
ip=`hostname -I | awk '{print $1}'`
echo "Using $ip as host IP address"
echo "Ensure this is correct to allow mininet to conect to the faucet and gauge controllers"

#ip=123.456.7.89
echo "Can be omitted for machines with static ip address\n"

# Run Faucet, Guage, Prometheus & Grafana-server
cd ~/workspace/faucet/
export FAUCET_EVENT_SOCK=1
export FAUCET_CONFIG_STAT_RELOAD=1
export FA_RABBIT_HOST=$ip
docker-compose -f docker-compose.yaml -f adapters/vendors/rabbitmq/docker-compose.yaml up --build -d

# Add permissions for mininet's xterms on the host machine
sudo xhost +

# Run Mininet
cd ~/workspace/docker-mininet
docker build -t mininet .
docker run -it --rm --privileged -e DISPLAY -e DOCKER_HOST=$ip -v /tmp/.X11-unix:/tmp/.X11-unix -v /lib/modules:/lib/modules -v ~/workspace/traffic:/traffic/ mininet
