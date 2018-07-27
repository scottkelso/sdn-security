#!/bin/bash

# Add device names according to mac addresses
# (http://149.171.189.1/resources/List_Of_Devices.txt)

for file in `ls`
do
  if [[ $file = *"d052a800675e"* ]]; then
    rename="SmartThings-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"44:65:0d:56:cc:d3"* ]]; then
    rename="AmazonEcho-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"70:ee:50:18:34:43"* ]]; then
    rename="NetatmoWelcome-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"f4:f2:6d:93:51:f1"* ]]; then
    rename="TPLinkCloudCamera-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"00:16:6c:ab:6b:88"* ]]; then
    rename="SamsungSmartCam-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"30:8c:fb:2f:e4:b2"* ]]; then
    rename="Dropcam-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"00:62:6e:51:27:2e"* ]]; then
    rename="InsteonCamera-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"00:24:e4:11:18:a8"* ]]; then
    rename="SmartBabyMonitor-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"ec:1a:59:79:f4:89"* ]]; then
    rename="BelkinWemoSwitch-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"50:c7:bf:00:56:39"* ]]; then
    rename="TPLinkSmartPlug-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"74:c6:3b:29:d7:1d"* ]]; then
    rename="iHome-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"ec:1a:59:83:28:11"* ]]; then
    rename="BelkinWemoMotionSensor-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"18:b4:30:25:be:e4"* ]]; then
    rename="NESTProtectSmokeAlarm-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"70:ee:50:03:b8:ac"* ]]; then
    rename="NetatmoWeatherStation-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"00:24:e4:1b:6f:96"* ]]; then
    rename="WithingsSmartScale-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"74:6a:89:00:2e:25"* ]]; then
    rename="BlipcareBloodPressureMeter-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"00:24:e4:20:28:c6"* ]]; then
    rename="AuraSmartSleepSensor-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"d0:73:d5:01:83:08"* ]]; then
    rename="LiFXSmartBulb-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"18:b7:9e:02:20:44"* ]]; then
    rename="TribySpeaker-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"e0:76:d0:33:bb:85"* ]]; then
    rename="PIXSTARPhotoFrame-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"70:5a:0f:e4:9b:c0"* ]]; then
    rename="HPPrinter-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"08:21:ef:3b:fc:e3"* ]]; then
    rename="SamsungGalaxyTab-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"30:8c:fb:b6:ea:45"* ]]; then
    rename="NestDropcam-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"40:f3:08:ff:1e:da"* ]]; then
    rename="AndroidPhone-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"74:2f:68:81:69:42"* ]]; then
    rename="Laptop-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"ac:bc:32:d4:6f:2f"* ]]; then
    rename="Macbook-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"b4:ce:f6:a7:a3:c2"* ]]; then
    rename="AndroidPhone-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"d0:a6:37:df:a1:e1"* ]]; then
    rename="iPhone-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"f4:5c:89:93:cc:85"* ]]; then
    rename="MacbookOrIphone-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  else if [[ $file = *"14:cc:20:51:33:ea"* ]]; then
    rename="TPLinkRouterBridgeLAN-"$file
    echo "Renaming $file to $rename"
    mv $file $rename
  fi
done
