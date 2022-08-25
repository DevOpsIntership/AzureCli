#!/bin/bash
echo "create resource group"
location=ukwest
name=test
az group create --location $location --name $name
