#!/bin/bash

# PREREQUISITS #
# config and label files are in the same place as trafficDir
# executed from PoseidonML root directory

trafficDir='/home/admin2/workspace/traffic/SanitizeNodes/'
onelayerDir='/home/admin2/workspace/PoseidonML/DeviceClassifier/OneLayer/'
testFile='AmazonEcho-160926-9-44650d56ccd3.pcap'

# rm $trafficDir"onelayer-logs.txt"
# pip install .

cp "${trafficDir}config.json" "${onelayerDir}opts/config.json"
cp "${trafficDir}label_assignments.json" "${onelayerDir}opts/label_assignments.json"

# TRAINING #
# export PCAP=$trafficDir"Training/"
# echo "Training..."
# make train_onelayer #>> $trafficDir"onelayer-logs.txt"

# EVALUATION #
# cp /tmp/models/OneLayerModel.pkl "${onelayerDir}models/OneLayerModel.pkl"
# cp /tmp/models/OneLayerModel.pkl "${trafficDir}Models/OneLayerModel.pkl"

cp "${trafficDir}Models/OneLayerModel.pkl" "${onelayerDir}models/OneLayerModel.pkl"

export PCAP="${trafficDir}Testing/${testFile}"
echo "Testing on $PCAP"
make eval_onelayer #>> $trafficDir"onelayer-logs.txt"
