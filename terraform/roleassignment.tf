resource "azurerm_role_assignment" "acrpull_role" {

  scope                = azurerm_container_registry.acr.id

  role_definition_name = "AcrPull"

  principal_id         = azurerm_linux_web_app.sampleapp.identity[0].principal_id

}