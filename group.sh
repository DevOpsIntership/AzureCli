#!/bin/bash
echo "create resource group"
location=ukwest
name=automationbash
az group create --location $location --name $name
