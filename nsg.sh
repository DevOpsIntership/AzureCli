#!/bin/bash
echo "Create NSG"
location=uksouth
resource=automation
arrayName=(NsgUbuntu NsgWindows)
arrayruleubuntu=(Allow Outbound)
arrayrulewindows=(Allow Deny Tcp 3389 Inbound)
for ((i=0; i<2; i++));
do
az network nsg create\
    --name ${arrayName[$i]}\
    --location $location\
    --resource-group $resource
done

az network nsg rule create\
    -g $resource\
    --nsg-name ${arrayName[0]}\
    --name AllowTrafic\
    --priority 1000\
    --access ${arrayruleubuntu[0]}\
    --direction ${arrayruleubuntu[1]}\
    --protocol '*'\
    --destination-port-ranges '*'

az network nsg rule create\
    -g $resource\
    --nsg-name ${arrayName[1]}\
    --name AllowRdp\
    --priority 1000\
    --access ${arrayrulewindows[0]}\
    --direction ${arrayrulewindows[4]}\
    --protocol ${arrayrulewindows[2]}\
    --destination-port-ranges ${arrayrulewindows[3]}


