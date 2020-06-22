provider "azurerm" {
  version = "=2.5.0"
  features {}
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = "servplanvg"
  location            = "southcentralus"
  resource_group_name = "RG-Academia-CoE"
  sku {
        tier = "Standard"
        size = "S1"
  }
}

