
from time import sleep

# host 1 ping host 2
h1.cmd('ping h2 &')
h1_pid = int( h1.cmd('echo $!') )

# host 2 become an iperf server
h2.cmd('iperf -s &')
h2_pid = int( h2.cmd('echo $!') )

# host 3 iperf host 2 iperf server
h3.cmd('iperf -c ' + net.get('h2') + ' -t 100 &')'
h3_pid = int( h3.cmd('echo $!') )

# host 4
h4.cmd('tcpreplay --loop=1000 --intf1=h4-eth0 /traffic/TenMinutesWebBrowsing.pcap &')
h4_pid = int( h4.cmd('echo $!') )

# host 5
h5.cmd('tcpreplay --loop=1000 --intf1=h5-eth0 /traffic/16-09-28.pcap &')
h5_pid = int( h5.cmd('echo $!') )

# host 6
h6.cmd('tcpreplay --loop=1000 --intf1=h6-eth0 /traffic/161012.pcap &')
h6_pid = int( h6.cmd('echo $!') )

# host 7
h7.cmd('tcpreplay --loop=1000 --intf1=h7-eth0 /traffic/JAN15-2016-EXT.pcap &')
h7_pid = int( h7.cmd('echo $!') )

# host 8
h8.cmd('tcpreplay --loop=1000 --intf1=h8-eth0 /traffic/IOT3-test.pcap &')
h8_pid = int( h8.cmd('echo $!') )

# host 9
sleep(60)
h9.cmd('tcpreplay --loop=1000 --intf1=h9-eth0 /traffic/SynFlood-test.pcap &')
h9_pid = int( h9.cmd('echo $!') )
