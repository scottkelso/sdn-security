#!/bin/bash

# Kill conflicting containers before startup
echo "Stopping and removing poseidon docker instances...."
for LOOP in `docker ps -aqf "name=cyberreboot"`
do
  docker stop $LOOP
  docker rm $LOOP
done

for LOOP in `docker ps -aqf "name=vent"`
do
  docker stop $LOOP
  docker rm $LOOP
done

echo "Exporting controller configuration..."
cd ~/workspace/poseidon/

export controller_uri=
export controller_type=faucet
export controller_log_file=/var/log/faucet/faucet.log
export controller_config_file=/etc/faucet/faucet.yaml
export controller_mirror_ports='{"sw1":10}' # dp and switch port to mirror to
export collector_nic=s1-eth10  # set the NIC of the machine that traffic will be mirrored to
export max_concurrent_reinvestigations=1  # if running FAUCET, this should be set to 1, if BCF, it can be a larger number

echo "$(env | grep -c "controller\|collector\|reinvestigations\|logger_level") variables exported" #should be 7

echo "Running Poseidon run script..."
./helpers/run
