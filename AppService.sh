#!/bin/bash
echo "Create AppService"

Region=$1
Name=AppServiceTest
Pricing_tier=B1
Nodes_in_web_farm=2
Docker_Hub_image=docker/getting-started

az appservice plan create\
    --resource-group automationbash\
    --name $Name\
    --location $Region\
    --is-linux\
    --number-of-workers $Nodes_in_web_farm\
    --sku $Pricing_tier\

    az webapp create\
    --resource-group automationbash\
    --plan $Name\
    --name adam98022test\
    --deployment-container-image-name $Docker_Hub_image\
