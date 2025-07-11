module "network" {
    source = "./../../modules/network"

   folder_id                    = var.folder_id 

   network_name         = var.network_name
   network_description  = var.network_description

   subnets                      = var.subnets

   dns_name                     = var.dns_name
   dns_description              = var.dns_description
   dns_zone                     = var.dns_zone
}