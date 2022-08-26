#!/bin/bash
resourcegroup=$1
resources="$(az resource list --resource-group $resourcegroup | grep id | awk -F \" '{print $4}')"

for id in $resources; do
    az resource delete --resource-group $resourcegroup --ids "$id" --verbose
done
