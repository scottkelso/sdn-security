str#!/usr/bin/python

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.util import dumpNodeConnections
from mininet.log import setLogLevel, info
from mininet.node import OVSSwitch, RemoteController
from mininet.cli import CLI
from time import sleep


def run():
    "Create and test a simple network"
    net = Mininet()

    info( "*** Creating Switches\n" )
    s1 = net.addSwitch('s1')

    info( "*** Creating hosts on s1\n" )
    for h in range(1,11):
        host = net.addHost('h%s' % h)
        net.addLink(host, s1)

    info( "*** Creating Faucet and Gauge controllers\n" )
    MININET_HOST_IP = "143.117.69.165"
    net.addController('c1', controller=RemoteController, ip=MININET_HOST_IP, port=6653)
    net.addController('c2', controller=RemoteController, ip=MININET_HOST_IP, port=6654)
    net.start()

    # info( "*** Running tests\n" )
    # print "Dumping host connections"
    # dumpNodeConnections(net.hosts)
    # print "Testing network connectivity"
    # net.pingAll()

    info( "*** Launching slave hosts\n" )
    # host 1 ping host 2
    h1 = net.get('h1')
    h1.cmd('ping h2 &')
    info("Host 1 slave task running on PID:" + str(h1.cmd('echo $!')))

    # host 2 become an iperf server
    h2 = net.get('h2')
    h2.cmd('iperf -s &')
    info("Host 2 slave task running on PID:" + str(h2.cmd('echo $!')))

    # host 3 iperf host 2 iperf server
    h3 = net.get('h3')
    h3.cmd('iperf -c ' + net.get('h2').IP() + ' -t 100 &')
    info("Host 3 slave task running on PID:" + str( h3.cmd('echo $!')))

    # host 4
    h4 = net.get('h4')
    h4.cmd('tcpreplay --loop=1000 --intf1=h4-eth0 /traffic/TenMinutesWebBrowsing.pcap &')
    info("Host 4 slave task running on PID:" + str( h4.cmd('echo $!')))

    # host 5
    h5 = net.get('h5')
    h5.cmd('tcpreplay --loop=1000 --intf1=h5-eth0 /traffic/16-09-28.pcap &')
    info("Host 5 slave task running on PID:" + str( h5.cmd('echo $!')))

    # host 6
    h6 = net.get('h6')
    h6.cmd('tcpreplay --loop=1000 --intf1=h6-eth0 /traffic/161012.pcap &')
    info("Host 6 slave task running on PID:" + str( h6.cmd('echo $!')))

    # host 7
    h7 = net.get('h7')
    h7.cmd('tcpreplay --loop=1000 --intf1=h7-eth0 /traffic/JAN15-2016-EXT.pcap &')
    info("Host 7 slave task running on PID:" + str( h7.cmd('echo $!')))

    # host 8
    h8 = net.get('h8')
    h8.cmd('tcpreplay --loop=1000 --intf1=h8-eth0 /traffic/IOT3-test.pcap &')
    info("Host 8 slave task running on PID:" + str( h8.cmd('echo $!')))

    # host 9
    h9 = net.get('h9')
    h9.cmd('tcpreplay --loop=1000 --intf1=h9-eth0 /traffic/SynFlood-test.pcap &')
    info("Host 9 slave task running on PID:" + str( h9.cmd('echo $!')))

    CLI(net)
    net.stop()

if __name__ == '__main__':
    # Tell mininet to print useful information
    setLogLevel('info')
    run()
