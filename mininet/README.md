# Mininet
I have usually run mininet with the following command which give me access to 9 hosts to use.
```commandline
mn --topo single,10 --mac --controller=remote,ip=$DOCKER_HOST,port=6653 --controller=remote,ip=$DOCKER_HOST,port=6654 --switch ovsk
```

I have included a `full-launch.sh` script which was intentionally to be used to launch all of the hosts into action with one command. However the mininet interface only allows execution of python scripts.

Another way I tried was to build my own custom mininet topology script which would replace the one above and would refactor all of the parameters out of the command needed to run it. This would also allow me to access the hosts and get them to execute the commands I want (as seen in `host-commands.py`).

However I wasn't happy with this either because none of the hosts were on screen and all these host commands where being run in the background. Managing the processes once they had been kicked off was too difficult so I opted for a compromise.

I load the mininet container with a bunch of scripts, named according to the host that would run that command. To kick each host off, one would just run that script because each host had access to the same volume.  See example below for hosts one and seven.
```commandline
sh /traffic/h1.sh
```
```commandline
sh /traffic/h7.sh
```

Not all of these scripts currently work on the Dell Ubuntu laptop I am setup on. These scripts will definitely need edited if setting up on another machine as those from host 4 onwards require particular pcap files to be in the traffic folder.

See below the current commands in each script.
