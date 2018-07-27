# Poseidon Scripts

### Poseidon's run script
_**Note**: This script is only to be used if the old method of running poseidon is preferable._

The following detail describes the workings of this script: `./run-poseidon.sh`. This script is that which I used to run Poseidon on a Dell Ubuntu 18.04 laptop. Remember to prefix the script with `sh` to run it like so...
```commandline
sh run-poseidon.sh
```

The following are the steps which this script takes...
1) Removes all existing cyberreboot or vent related containers and images so that they do not conflict with those that are trying to start up. We have also been using a number of more powerful docker scripts for removing existing containers. Some of these can be found [here](https://github.com/scottkelso/docker-scripts).
2) Exports the required poseidon config variables needed to setup a connection to the faucet controller etc.  The exports used are listed below.
```commandline
export controller_uri=
export controller_type=faucet
export controller_log_file=/var/log/faucet/faucet.log
export controller_config_file=/etc/faucet/faucet.yaml
export controller_mirror_ports='{"sw1":10}'
export collector_nic=s1-eth10
export max_concurrent_reinvestigations=1
```

3) Run poseidon's `./helpers/run` script. This script should show output like the following for a few minutes. 
```commandline
./helpers/run 
ea8b574ae2a68de19ed5b6fd92796d444c0fe89138507b62b5cbc5c802b3ab4d
waiting for required containers to build and start (this might take a little while)...
```

If this output remains for more than 3 or 4 minutes then it is likely that the poseidon container has not started. Unfortunately we do not know what causes this. (There should be 13 cyberreboot or vent containers up if successful) 



### Faucet and Mininet's run script
The `run-faucnet.sh` script builds and runs a docker-compose command which launches Faucet, Guage, Prometheus, Grafana-server and Mininet in containers.  

## PREREQUISITS...
# ~/workspace/faucet/
One must have the faucet codebase cloned into a workspace folder.
```commandline
cd ~/workspace
git clone https://github.com/faucetsdn/faucet
```

# ~/workspace/docker-mininet
One must the docker-mininet codebase cloned into a workspace folder. You could use the [original docker-mininet](https://github.com/iwaseyusuke/docker-mininet) but I have added some useful tools into [this one].(https://github.com/scottkelso/docker-mininet)
```commandline
cd ~/workspace
git clone https://github.com/scottkelso/docker-mininet
```

# ~/workspace/traffic
One must have a traffic folder for data to be mounted into the mininet image. Files may include pcaps that can be replayed to simulate particular traffic or scripts that can be run by individual hosts. 

_From within mininet, remember to prefix the path with a forward slash because these folders are in root._
```commandline
mininet> h1 ls traffic/
ls: cannot access 'traffic/': No such file or directory

mininet> h1 ls /traffic/
FullNodeExtract        SanitizedNode.pcap
OneTwoThree            h10.sh
```

# docker & docker-compose
Need installed.

# sudo xhost
Make sure you have sudo rights so that one can disable access rights for Mininet to use the host machine to launch terminals on for each of the hosts so that one can interact with each host easier. See [here](https://github.com/iwaseyusuke/docker-mininet) for details on this step.

## Launch Mininet
When you are ready to launch the mininet topology, copy and paste the following command (which can also be accessed in the `cold-start.txt` file) and run within the running mininet container.

```commandline
mn --topo single,10 --mac --controller=remote,ip=$DOCKER_HOST,port=6653 --controller=remote,ip=$DOCKER_HOST,port=6654 --switch ovsk
```
One can also append the `-x` option onto this command to automatically launch xterms for each host. This is useful to do to test that the xterm permissions are working correctly. 

The above command runs a topology with one active controller on port 6653 (that is faucet) and another just for monitoring on port 6654 (that is gauge). The network has one open flow switch and 10 hosts. Hosts are named `h1` up to `h9`. There does exist a `h10` host but this is for mirroring all network traffic to for poseidon to scrape from. 

I have also included our faucet and gauge configuration yamls for reference. The `faucet.yaml` needs to be the same (or equivalent) for the above mininet topology to work. These two files live here: `/etc/faucet/ `. See [here](https://faucet.readthedocs.io/en/latest/tutorials/first_time.html#configure-faucet) for details of how to make sure your faucet directories are setup.