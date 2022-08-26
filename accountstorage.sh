#!/bin/bash
location=ukwest
resourceGroup=$1
storage="accountstorageadam7652"
container="dotnetbackup2"
access="Hot"
key=$(az storage account keys list --account-name $storage --resource-group $resourceGroup -o json --query [0].value | tr -d '"')

echo "Creating $storage"

az storage account create\
    --name $storage\
    --resource-group $resourceGroup\
    --location $location\
    --access-tier $access\

az storage container create\
    --name $container\
    --account-name $storage\
    --account-key $key\

