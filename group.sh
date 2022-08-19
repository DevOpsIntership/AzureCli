#!/bin/bash
echo "create resource group"
echo "location"
read location
echo "name"
read name
az group create --location $location --name $name
