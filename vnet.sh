#!/bin/bash
echo "create vnet"
name=Vnet
location=ukwest
resource=automationbash
address=10.0.0.0/16
subnetArray=(10.0.0.0/25 10.0.0.128/25)
subnetName=(ubuntu windows)
len=${#subnetArray[@]}
az network vnet create\
    --location $location\
    --name $name\
    --resource-group $resource\
    --address-prefix $address 
for (( i=0; i<$len; i++ ));
do
az network vnet subnet create\
    --name ${subnetName[$i]}\
    --vnet-name $name\
    --resource-group $resource\
    --address-prefixes ${subnetArray[$i]} 
done

