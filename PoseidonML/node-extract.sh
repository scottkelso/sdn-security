#!/bin/bash

# Check that a file to process has been passed in
if (( $# > 1 )); then

  # Set maximum number of nodes to extract
  if [ "$3" != "" ]; then
    max=$3
  else
    max=9
  fi

  # Extract each node via mac address
  inputfile=$1
  outputfile=$2
  count=1

  echo "Counting mac address packets..."
  for mac in `tshark -r $inputfile -T fields -e eth.src | sort | uniq | head -n $max`
  do
    echo "Exctracting node $count ($mac)"
    macString=${mac//:}
    output="$outputfile-$count-$macString.pcap"
    tcpdump ether host $mac -r $inputfile -w $output
    count=$((count+1))
  done

else
  echo "USAGE: bash node-extract.sh <inputfile> <outputfilename> [Max nodes to extract (default is 9)]"
  echo "EG: bash ../../../node-extract.sh ~/workspace/traffic/16-09-23.pcap 160923"
fi
