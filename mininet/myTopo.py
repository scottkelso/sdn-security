#!/usr/bin/python

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.util import dumpNodeConnections
from mininet.log import setLogLevel, info
from mininet.node import OVSSwitch, RemoteController

class MyTopo(Topo):

    def build(self, n=2):

        MININET_HOST_IP = "143.117.69.165"

        info( "*** Creating Faucet and Guage controllers\n" )
        faucet = self.addController( 'faucet', controller=RemoteController, ip=MININET_HOST_IP, port=6653 )
        guage = self.addController( 'guage', controller=RemoteController, ip=MININET_HOST_IP, port=6654 )


        info( "*** Creating Switches\n" )
        s1 = self.addSwitch( 's1' )
        s2 = self.addSwitch( 's2' )

        info( "*** Creating hosts on s1\n" )
        for h in range(1,3):
            host = self.addHost('h%s' % h)
            self.addLink(host, s1)

        info( "*** Creating hosts on s2\n" )
        for h in range(4,6):
            host = self.addHost('h%s' % h)
            self.addLink(host, s2)


def simpleTest():
    "Create and test a simple network"
    topo = MyTopo(n=4)
    net = Mininet(topo)
    net.start()
    print "Dumping host connections"
    dumpNodeConnections(net.hosts)
    print "Testing network connectivity"
    net.pingAll()
    net.stop()

if __name__ == '__main__':
    # Tell mininet to print useful information
    setLogLevel('info')
    simpleTest()
