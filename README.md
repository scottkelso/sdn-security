# Using Machine Learning to detect Security Issues in SDN's

The following is a technical guide for setting up the virtual network and outlining details about the final system that we completed during our summer research internship.
*Note: I my change between using I and we to identify myself. The reason for this is that I was not the only one working on this project (see contributers list).

During these eight weeks, I feel that we didn't actually get very close at all to our intended goal. 
## Our Original Goal
This can be broken down into a number of steps.
 1) Setup the Poseidon and Mininet system
 2) Chose at least one type of known network attack to run on the system 
 3) Try tuning the current ML algorithms or implementing our own to detect this malicious traffic
 4) Use poseidon's connection to the SDN controller to perform an action on the source of the malicious traffic
 
By the last week, we had completed points 1 and 2, but only partially attempted 3 and 4. Limitations around these two uncompleted points arose due to the fragile and feature-light state poseidon is currently in. We were expecting feature 4 to be easily activated but discovered that there is next to no code in master to do this. We therefore attempted a quick, hacky version ourselves for a proof of concept. This is not complete at the time I am writing this report.

## Prerequisits
- This guide assumes you have a linix based OS (we used Ubuntu 16.04 and 18.04, however we would advise using a more stable OS such as [CentOS](https://www.centos.org/))
The following packages will been installed prior to using any of the scripts or commands below
- docker
- docker-compose

## Running the live system
### Order 
We found that there was a particular order of setup which made everything run a lot smoother.
1) Poseidon - one of two run methods detailed below
2) Faucet, Gauge, Grafana, Prometheus - using docker-compose
3) Mininet - using docker

### 1) Poseidon
Currently there are two different ways to install and run poseidon. 
#### Poseidon's debian apt-get package
This is currently Cyberreboot's preferred method. Installation via the debian apt-get package gives a handy terminal command for restarting, reconfiguring and seeing logs. Use `poseidon help` to see the other options that are available. Under the hood this method does the same thing that the original and second method does - runs a `docker run` command and waits for all 13 containers necessary to spawn. However this method was giving us [problems](https://github.com/CyberReboot/poseidon/issues/688). See [here](https://github.com/CyberReboot/poseidon#installing) for installation. Sometimes if all 13 containers showed that they were all up but no more logs showed what was happening next, we can jump into the system log container with the following command.
```commandline
docker logs -f cyberreboot-vent-syslog-master
```
This same syntax can be used to jump into any of the running containers, no matter the method used to install.

During the installation process, there is a handy terminal UI for setting the config variables which poseidon needs to run. These are exported into poseidon internally. The codebase for this method is stored at `/opt/poseidon`. This is where you will find the `.vent_startup.yml` file which points to the different vent plugins.

To run our own version of PoseidonML and poseidon, we change the URIs in this file to that of our forked versions. The original config files also live here, such as the `./config/poseidon.config` file and the `.plugin_config`. These were originally used to hardcode our configurations in, but this is not the preferred way of giving poseidon it's configs.

As mentioned before, there were issues with this method so we primarilly used the following method which was the original way to run poseidon.

#### Poseidon's run script
The following detail describes the workings of this script: `./run-poseidon.sh`. This script is that which I used to run Poseidon on a Dell Ubuntu 18.04 laptop. Remember to prefix the script with `sh` to run it like so...
```commandline
sh run-poseidon.sh
```

Contained within poseidon's codebase there is a run script that can be run via the root of the cloned repo like the following...
```commandline
git clone https://github.com/cyberreboot/poseidon.git
cd poseidon
***environment variables***
./helpers/run
```

The other step necessary for the simplified code above to work is the environment variables to be exported. Like the terminal UI described above, we need to tell poseidon configuration variables. We do this by exporting them to the environment. We can do this with the following code.
```commandline
export controller_uri=
export controller_type=faucet
export controller_log_file=/var/log/faucet/faucet.log
export controller_config_file=/etc/faucet/faucet.yaml
export controller_mirror_ports='{"sw1":10}'
export collector_nic=s1-eth10
export max_concurrent_reinvestigations=1
```

#### How Poseidon Actually Runs
Whether one executes the `./helpers/run` script or uses the poseidon command `poseidon -s`, the same thing is happening under the hood. A [cyberreboot/vent]() container is being run with all the configurations we have past it. Infact, we aren't really running poseidon when we using any of the commands described. We are running vent, which runs plugins including poseidon, PoseidonML and CRviz. Vent does this using it's startup file which tells it the URIs for what plugins to pull, build and run.

### 2) Faucet, Gauge, Grafana, Prometheus & 3) Mininet
These two steps have been segregated because mininet cannot start without all the components of step 2. However they can both be run one after the other using one of the scripts `run-faucnet.sh`.


## Contributers
- [Josh Kelso](https://github.com/scottkelso) - Focus on virtual mininet system
- [James Aiken](https://github.com/jaiken06) - Focus on physical raspberry pi and Zodiac switch system
