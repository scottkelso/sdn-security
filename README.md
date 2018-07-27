# Using Machine Learning to detect Security Issues in SDN's

The following is a technical guide for setting up the virtual network and outlining details about the final system that we completed during our summer research internship.

_**Note**: I may change between using **"I"** and **"we"** to identify myself. The reason for this is that I was not the only one working on this project (see contributers list)._

During these eight weeks, I feel that we didn't actually get very close to what I had intended to achieve. 
## Our Original Goal
This can be broken down into a number of steps.
 1) Setup the Poseidon and Mininet system
 2) Chose at least one type of known network attack to run on the system 
 3) Try tuning the current ML algorithms or implementing our own to detect this malicious traffic
 4) Use poseidon's connection to the SDN controller to perform an action such as blocking the malicious traffic
 
By the last week, we had completed points 1 and 2, but only partially attempted 3 and 4. Limitations around these two uncompleted points arose due to the fragile and feature-light state poseidon is currently in. We were expecting feature 4 to be easily activated but discovered that there is next to no code in master to do this. We therefore attempted a quick, version ourselves for a proof of concept. This is not complete at the time I am writing this report.

## Prerequisits
- This guide assumes you have a linix based OS (we used Ubuntu 16.04 and 18.04, however we would advise using a more stable OS such as [CentOS](https://www.centos.org/)).

The following packages will been installed prior to using any of the scripts or commands below
- docker
- docker-compose

## Running the live system
### Order 
There is a particular order of setup which made everything run a lot smoother. Due to [this issue](https://github.com/CyberReboot/poseidon/issues/688) the order of execution has been changed and the new order is detailed below. 
1) Faucet, Gauge, Grafana, Prometheus - using docker-compose
2) Poseidon - one of two run methods detailed below
3) Mininet - using docker

Faucet is required before running poseidon.  Mininet is still best running last.

### 1) Faucet, Gauge, Grafana, Prometheus
The four packages above can all be spun up using `docker-compose`.  A docker extension for managing multiple container orchestrations. Some exports are needed prior to running the docker-compose command. All of these are handled in the `run-faucnet.sh` script which also builds the mininet container ready for mininet to be initialised.

When all of the above packages are up and running, one should be able to see the following containers up and running by running `docker ps`.
```commandline
CONTAINER ID        IMAGE                                  COMMAND                  CREATED             STATUS                  PORTS                                                      NAMES
7cb7ff969c90        mininet                                "/ENTRYPOINT.sh"         23 hours ago        Up 23 hours             6633/tcp, 6640/tcp, 6653/tcp                               compassionate_jang
be14b7f05136        grafana/grafana:5.1.3                  "/run.sh"                23 hours ago        Up 23 hours             0.0.0.0:3000->3000/tcp                                     faucet_grafana_1
08ddc538e799        prom/prometheus:v2.2.1                 "/bin/prometheus --c…"   23 hours ago        Up 23 hours             0.0.0.0:9090->9090/tcp                                     faucet_prometheus_1
03e496eff7f2        faucet/event-adapter-rabbitmq          "/usr/local/bin/entr…"   23 hours ago        Up 23 hours                                                                        faucet_rabbitmq_adapter_1
22adfd7cd048        faucet/gauge:latest                    "/usr/local/bin/entr…"   23 hours ago        Up 23 hours             0.0.0.0:6654->6653/tcp, 0.0.0.0:32816->9303/tcp            faucet_gauge_1
84456e8623cc        influxdb:1.3-alpine                    "/entrypoint.sh infl…"   23 hours ago        Up 23 hours             0.0.0.0:32814->8083/tcp, 0.0.0.0:32813->8086/tcp           faucet_influxdb_1
f93eaa26c018        faucet/faucet:latest                   "/usr/local/bin/entr…"   23 hours ago        Up 23 hours             0.0.0.0:6653->6653/tcp, 0.0.0.0:32815->9302/tcp            faucet_faucet_1
```

### 2) Poseidon
Currently there are two different ways to install and run poseidon. 
#### Poseidon's debian apt-get package
This is currently Cyberreboot's preferred method. Installation via the debian apt-get package gives a handy terminal command for restarting, reconfiguring and seeing logs. Use `poseidon help` to see the other options that are available. Under the hood this method does the same thing that the original and second method does - (runs a `docker run` command and waits for all 13 containers necessary to spawn). See [here](https://github.com/CyberReboot/poseidon#installing) for installation. 

Sometimes if all 13 containers showed that they were all up but no more logs showed what was happening next, we can jump into the system log container with the following command.
```commandline
docker logs -f cyberreboot-vent-syslog-master
```
This same syntax can be used to jump into any of the running containers, no matter the method used to install.

During the installation process, there is a handy terminal UI for setting the config variables which poseidon needs to run. These are exported into poseidon internally (see the `run-poseidon.sh` script for what these should be). The codebase for this installation method of poseidon is stored at `/opt/poseidon`. This is where you will find the `.vent_startup.yml` file which points to the different vent plugins.

To run our own version of PoseidonML and poseidon, we change the URIs in this file to that of our forked versions. The original config files also live here, such as the `./config/poseidon.config` file and the `.plugin_config`. These were originally used to hardcode our configurations in, but this is not the preferred way of giving poseidon it's configs.


#### How Poseidon Actually Runs
Whether one executes the `./helpers/run` script or uses the poseidon command `poseidon -s`, the same thing is happening under the hood. A [cyberreboot/vent]() container is being run with all the configurations we have past it. Infact, we aren't really running poseidon when we using any of the commands described. We are running vent, which runs plugins including poseidon, PoseidonML and CRviz. Vent does this using it's startup file which tells it the URIs for what plugins to pull, build and run.

### 2) Faucet, Gauge, Grafana, Prometheus & 3) Mininet
These two steps have been segregated because mininet cannot start without all the components of step 2. However they can both be run one after the other using one of the scripts `run-faucnet.sh`.


## Contributers
- [Josh Kelso](https://github.com/scottkelso) - Focus on virtual mininet system
- [James Aiken](https://github.com/jaiken06) - Focus on physical raspberry pi and Zodiac switch system
