#!/bin/bash
echo "create resource group"
location=ukwest
name=$1
az group create --location $location --name $name
