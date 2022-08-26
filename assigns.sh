#!/bin/bash
echo "assigns NSG to vnet subnet"
nsgname=(NsgUbuntu NsgWindows)
vnetname=Vnet
subnetname=(ubuntu windows)
rg=$1
for ((i=0; i<2; i++))
do
az network vnet subnet update\
    --resource-group $rg\
    --vnet-name $vnetname\
    --name ${subnetname[$i]}\
    --network-security-group ${nsgname[$i]}
done    
    
