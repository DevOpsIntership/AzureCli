#!/bin/bash
echo "Creating backup"

resourceGroup="automationbash"
webapp="dotnetwebappbackup"
storage="accountstorageadam7652"
container="dotnetbackup2"
backup="backupdotnet"
expirydate=$(date -I -d "$(date) + 1 month")
access="Hot"
frequency=1d
key=$(az storage account keys list --account-name $storage --resource-group $resourceGroup -o json --query [0].value | tr -d '"')
sastoken=$(az storage container generate-sas --account-name $storage --name $container --account-key $key \
--expiry $expirydate --permissions rwdl --output tsv)

sasurl=https://$storage.blob.core.windows.net/$container?$sastoken


az webapp config backup create --resource-group $resourceGroup --webapp-name $webapp \
--backup-name $backup --container-url $sasurl

az webapp config backup list --resource-group $resourceGroup --webapp-name $webapp

az webapp config backup update --resource-group $resourceGroup --webapp-name $webapp \
--container-url $sasurl --frequency $frequency --retain-one true --retention 10


az webapp config backup show --resource-group $resourceGroup --webapp-name $webapp