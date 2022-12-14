resource "azurerm_cosmosdb_account" "db" {
  name = "maxcosmosdb1"
  location = "UK West"
  resource_group_name = "maxrg1"
  offer_type = "Standard"
  

  consistency_policy {
    consistency_level = "Session"
    max_interval_in_seconds = 300
    max_staleness_prefix = 100000
  }
  
  geo_location {
    location = azurerm_resource_group.rg.location
    failover_priority = 0
  }

}

resource "azurerm_cosmosdb_sql_database" "dbacc" {
  name                = "maxdb"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.db.name
}

resource "azurerm_cosmosdb_sql_container" "condb" {
  name                  = "Items"
  resource_group_name   = azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.db.name
  database_name         = azurerm_cosmosdb_sql_database.dbacc.name
  partition_key_path    = "/id"
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}