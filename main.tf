locals {
  # Read and decode the contents of each JSON file
  lennar_prod_subscriptions = jsondecode(file("${path.module}/subscriptions/lennar_prod_subscriptions.json"))
  lennar_nonprod_subscriptions = jsondecode(file("${path.module}/subscriptions/lennar_nonprod_subscriptions.json"))
  
  # Dynamically concatenate all subscription arrays
  all_subscriptions = concat(local.lennar_prod_subscriptions, local.lennar_nonprod_subscriptions)
}

module "subscription_vending" {
  source  = "Azure/lz-vending/azurerm"
  version = "4.1.4" 

  for_each = { for subscription in local.all_subscriptions : subscription.subscription_alias_name => subscription }

  # Set the default location for resources
  location = var.location

  # Subscription variables
  subscription_alias_enabled = each.value.subscription_alias_enabled
  subscription_billing_scope = each.value.subscription_billing_scope
  subscription_display_name  = each.value.subscription_display_name
  subscription_alias_name    = each.value.subscription_alias_name
  subscription_workload      = each.value.subscription_workload

  network_watcher_resource_group_enabled = each.value.network_watcher_resource_group_enabled

  # Management group association variables
  subscription_management_group_association_enabled = each.value.subscription_management_group_association_enabled
  subscription_management_group_id                  = each.value.subscription_management_group_id

  budget_enabled = each.value.budget_enabled
  budgets = each.value.budgets

  resource_group_creation_enabled = each.value.resource_group_creation_enabled
  resource_groups = each.value.resource_groups

  # Virtual network variables - set to false, as this is managed by Network team in a separate repo
  virtual_network_enabled = each.value.virtual_network_enabled
  virtual_networks = {
    # one = {
    #   name                    = "my-vnet"
    #   address_space           = ["192.168.1.0/24"]
    #   hub_peering_enabled     = true
    #   hub_network_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-hub-network-rg/providers/Microsoft.Network/virtualNetworks/my-hub-network"
    #   mesh_peering_enabled    = true
    # }
    # two = {
    #   name                    = "my-vnet2"
    #   location                = "northeurope"
    #   address_space           = ["192.168.2.0/24"]
    #   hub_peering_enabled     = true
    #   hub_network_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-hub-network-rg/providers/Microsoft.Network/virtualNetworks/my-hub-network2"
    #   mesh_peering_enabled    = true
    # }
  }

  # User-assigned managed identity
  umi_enabled             = each.value.umi_enabled

  # Role assignments
  role_assignment_enabled = each.value.role_assignment_enabled
}