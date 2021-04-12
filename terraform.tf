terraform {
    backend "azurerm"
    resource_group_name = "remote-state"
    #modify the storage account name"
    storage_account_name = "terraformgopal"
    container_name = "tfstate"
    key = "web.tfstate"
}