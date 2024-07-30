terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = module.map.full.gis_nonprod_ue2
}


# toolbox provider
provider "azurerm" {
  alias   = "toolbox"
  features {}
  subscription_id = "498f05c7-7aa5-4fd5-8e86-afe42d55808a"
}
