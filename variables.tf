variable "location" {
  type        = string
  description = <<DESCRIPTION
The default location of resources created by this module.
Virtual networks will be created in this location unless overridden by the `location` attribute.
DESCRIPTION
  default = "eastus"
}

variable "disable_telemetry" {
  type        = bool
  description = <<DESCRIPTION
To disable tracking, we have included this variable with a simple boolean flag.
The default value is `false` which does not disable the telemetry.
If you would like to disable this tracking, then simply set this value to true and this module will not create the telemetry tracking resources and therefore telemetry tracking will be disabled.

For more information, see the [wiki](https://aka.ms/lz-vending/tf/telemetry)

E.g.

```terraform
module "lz_vending" {
  source  = "Azure/lz-vending/azurerm"
  version = "<version>" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  # ... other module variables

  disable_telemetry = true
}
```
DESCRIPTION
  default     = false
}

variable "subscriptions" {
    type = map(object({
        subscription_alias_enabled = bool
        subscription_billing_scope = string
        subscription_display_name  = string
        subscription_alias_name    = string
        subscription_workload      = string
        network_watcher_resource_group_enabled = bool
        subscription_management_group_association_enabled = bool
        subscription_management_group_id                  = string   

        budget_enabled = bool
        budgets = map(object({
            amount            = number
            time_grain        = string
            time_period_start = string
            time_period_end   = string
            relative_scope    = optional(string, "")
            notifications = optional(map(object({
                enabled        = bool
                operator       = string
                threshold      = number
                threshold_type = optional(string, "Actual")
                contact_emails = optional(list(string), [])
                contact_roles  = optional(list(string), [])
                contact_groups = optional(list(string), [])
                locale         = optional(string, "en-us")
            })), {})
        }))

        resource_group_creation_enabled = bool
        resource_groups = map(object({
            name     = string
            location = string
            tags     = optional(map(string), {})
        }))
        
        virtual_network_enabled = bool
        umi_enabled = bool
    }))
}