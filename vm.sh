echo "create VMs"
vmname=(agnent-01 agent-02 agent-03)
vmnamew=jumpox01
vmimage=UbuntuLTS
vmimagew=MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest 
Vmpricingtier=Standard_DS1_v2
vnet=Vnet
VmDisktier=Standard_LRS
subnetubuntu=ubuntu 
subnetwindows=windows
rg=$1
nsg=NsgUbuntu
nsgw=NsgWindows 
Ipnameubuntu=(Ipagent01 Ipagent02 Ipagent03)
Ipnamewindows=ipjumpbox01
Nicnameubuntu=(NicUbuntu01 Nicnubuntu02 Nicubuntu03)
NicnameWindows=jumpox01nic
dnsname=(agnent-01ubuntutest11 agent-02ubuuntutest22 agent-03ubuntutest33)

for ((i=0; i<3; i++))
do
az network public-ip create \
    --resource-group $rg \
    --name ${Ipnameubuntu[$i]} \
    --allocation-method Dynamic\
    --dns-name ${dnsname[$i]}\

az network nic create \
    --resource-group $rg\
    --name ${Nicnameubuntu[$i]}\
    --vnet-name $vnet\
    --subnet $subnetubuntu\
    --network-security-group $nsg\
    --public-ip-address ${Ipnameubuntu[$i]}\

    az vm create\
            --name ${vmname[$i]}\
            --resource-group $rg\
            --image $vmimage\
            --admin-username azureuser\
            --nics ${Nicnameubuntu[$i]}\
            --storage-sku $VmDisktier\
            --generate-ssh-keys
done



az network public-ip create \
    --resource-group $rg \
    --name $Ipnamewindows\
    --sku Standard\
    --allocation-method Static\

az network nic create \
    --resource-group $rg\
    --name $NicnameWindows\
    --vnet-name $vnet\
    --subnet $subnetwindows\
    --network-security-group $nsgw\
    --public-ip-address $Ipnamewindows\

    az vm create\
            --name $vmnamew\
            --resource-group $rg\
            --image $vmimagew\
            --admin-username azureuser\
            --nics $NicnameWindows\
            --storage-sku $VmDisktier\
            
            
