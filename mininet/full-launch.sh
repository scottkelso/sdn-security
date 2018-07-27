#!/bin/bash

clean_up () {
    echo "Cleaning up..."
    h1 kill h1_pid
    h2 kill h2_pid
    h3 kill h3_pid
    h4 kill h4_pid
    h5 kill h5_pid
    h6 kill h6_pid
    h7 kill h7_pid
    h8 kill h8_pid
    h9 kill h9_pid
    echo "All cleaned up"
    echo "Exiting..."
}
trap clean_up EXIT

# host 1 ping host 2
h1 ping h2 &
h1_pid=$!

# host 2 become an iperf server
h2 iperf -s &
h2_pid=$!

# host 3 iperf host 2 iperf server
iperf -c 10.0.0.2 -t 100 &
h3_pid=$!

# host 4
tcpreplay --loop=1000 --intf1=h4-eth0 /traffic/TenMinutesWebBrowsing.pcap &
h4_pid=$!

# host 5
tcpreplay --loop=1000 --intf1=h5-eth0 /traffic/16-09-28.pcap &
h5_pid=$!

# host 6
tcpreplay --loop=1000 --intf1=h6-eth0 /traffic/161012.pcap &
h6_pid=$!

# host 7
tcpreplay --loop=1000 --intf1=h7-eth0 /traffic/JAN15-2016-EXT.pcap &
h7_pid=$!

# host 8
tcpreplay --loop=1000 --intf1=h8-eth0 /traffic/IOT3-test.pcap &
h8_pid=$!

# host 9
sleep 60
tcpreplay --loop=1000 --intf1=h9-eth0 /traffic/SynFlood-test.pcap &
h9_pid=$!
