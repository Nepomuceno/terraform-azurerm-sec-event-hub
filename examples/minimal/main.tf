provider "azurerm" {
  version = "~>2.0"
  features {}
}

locals {
  unique_name_stub = substr(module.naming.unique-seed, 0, 5)
}

module "naming" {
  source = "git::https://github.com/Azure/terraform-azurerm-naming"
}

resource "azurerm_resource_group" "test_group" {
  name     = "${module.naming.resource_group.slug}-${module.naming.eventhub.slug}-min-test-${local.unique_name_stub}"
  location = "uksouth"
}

module "terraform-azurerm-event-hub" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test_group.name
}
