#!/bin/bash

# PREREQUISITS #
# config and label files are in the same place as trafficDir
# executed from PoseidonML root directory
# exists ~/workspace/svm-eval.txt

trafficDir='/home/admin2/workspace/traffic/SanitizeNodes/'
svmDir='/home/admin2/workspace/PoseidonML/DeviceClassifier/SVM/'

# # TRAINING #
# pip install .
# cp "${trafficDir}config.json" "${svmDir}opts/config.json"
# cp "${trafficDir}label_assignments.json" "${svmDir}opts/label_assignments.json"
# export PCAP="${trafficDir}Training/"
# echo "Training..."
# make train_svm >> ../svm-eval.txt

# EVALUATION #
cp /tmp/models/SVMModel.pkl "${svmDir}models/SVMModel.pkl"
cp /tmp/models/SVMModel.pkl "${trafficDir}Models/SVMModel.pkl"

echo "Evaluating..."
for pcap in ~/workspace/traffic/SanitizeNodes/Testing/*.pcap
do
  # export PCAP=$pcap
  # # make eval_onelayer
  echo $pcap
  echo "X"
done
