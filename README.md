# Azure Subscriptions Vending

## Overview
This repository is used to provision new subscriptions using corporate defaults for provisioning the foundational resources

## Components automated
- Create subscription in specified billing scope
- Add budgets and alerts
- Add resource groups
- Capable to create vNets and subnets (disabled in this repo because it is managed part of Network repo)
- Assign RBAC roles

## Steps to create and customize a new subscription
- Add a JSON object to the JSON arrays in appropriate files under ./subscriptions folder
- Create PR and merge into develop branch
- Create a tag to trigger terraform apply

## References
[Azure Landing Zone vending code repo](https://github.com/Azure/terraform-azurerm-lz-vending)
