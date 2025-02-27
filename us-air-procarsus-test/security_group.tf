module "nsg" {
  source              = "git::git@git.signintra.com:dct/azure/terraform-azurerm-nsg.git"
  location            = data.azurerm_resource_group.rg_nonprod.location
  resource_group_name = data.azurerm_resource_group.rg_nonprod.name
  security_group_name = "${var.topic}-${var.stage}-nsg-${var.application}-${module.map.region_map[var.location]}"

  custom_rules = [
    
    {
      name                                       = "AllowSSH"
      priority                                   = "121"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      destination_port_range                     = "22"
      source_address_prefix                      = "10.236.247.0/27"
      
      destination_application_security_group_ids = [module.vm.asg]
    },
    {
      name                   = "BlockAny"
      priority               = "2000"
      direction              = "Inbound"
      access                 = "Deny"
      protocol               = "Tcp"
      source_port_ranges     = "*"
      destination_port_range = "*"
      description            = "BlockAny"
    },
  ]

  dynamic_rules = [
    
    /*
    {
      name                                       = "AllowSQL"
      priority                                   = "126"
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      destination_port_range                     = "1433"
      source_address_prefixes                    = ["10.0.0.0/8"]
      destination_application_security_group_ids = [module.vm.asg]
    },
    */
  ]

  tags = local.tags
}
