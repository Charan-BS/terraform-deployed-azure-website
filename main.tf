provider "azurerm"{
    features {}
    subscription_id = "c62e7aad-fd27-4d41-985b-be9217ce6a81"
}

#creating a resource group
resource "azurerm_resource_group" "resource_group" {
    name = "rg-terraform-by-cbs"
    location = "eastus"
}

#creating storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformyoyocbs"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"

  static_website {
    index_document = "index.html"
  }
}

#add a index.html file
resource "azurerm_storage_blob" "blob" {
    name = "index.html"
    storage_account_name = azurerm_storage_account.storage_account.name
    storage_container_name = "$web"
    type = "Block"
    content_type = "text/html"
    source_content = "<h1> Finally, my first website deployed </h1> <h2> Charan B S </h2>"
}
