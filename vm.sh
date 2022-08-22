#!/bin/bash
echo "create VMs"
vmname=agnent-01a
vmimage=UbuntuLTS
Vmpricingtier=Standard_DS1_v2
vnet=Vnet
subnet=ubuntu
domainname=
reservedip=

if [[ "$domainname" == '' && "$reservedip" == '' ]] ; then
        az vm create\
            --name $vmname\
            --resource-group automation\
            --image $vmimage\
            --vnet-name $vnet\
            --subnet $subnet\
            --generate-ssh-keys

elif [[ "$domainname" != '' && "$reservedip" == '' ]] ; then
        az vm create\
            --name $vmname\
            --resource-group automation\
            --image $vmimage\
            --vnet-name $vnet\
            --subnet $subnet\
            --public-ip-address-dns-name $domainname
            --generate-ssh-keys

elif [[ "$domainname" == '' && "$reservedip" != '' ]] ; then
        az vm create\
            --name $vmname\
            --resource-group automation\
            --image $vmimage\
            --vnet-name $vnet\
            --subnet $subnet\
            --public-ip-address-allocation static
            --generate-ssh-keys  
else 
        az vm create\
            --name $vmname\
            --resource-group automation\
            --image $vmimage\
            --vnet-name $vnet\
            --subnet $subnet\
            --public-ip-address-dns-name $domainname
            --public-ip-address-allocation static
            --generate-ssh-keys                             
fi

