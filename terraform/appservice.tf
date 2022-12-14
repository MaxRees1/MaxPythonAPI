

resource "azurerm_service_plan" "example" {
  name                = "maxappplan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "sampleapp" {
  name = "exampleappservice444"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id = azurerm_service_plan.example.id
  identity {
    type = "SystemAssigned"
  }
  site_config {
    application_stack { 
    docker_image = "maxreg2.azurecr.io/app-new"
    docker_image_tag = "latest"
    }
    container_registry_use_managed_identity = true
  }
  app_settings = {
    primarykey = azurerm_cosmosdb_account.db.primary_key
    cosmosurl = azurerm_cosmosdb_account.db.endpoint
  }




}

