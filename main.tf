module "core-networking" {
  source        = "./modules/core-networking"
  project       = var.gcp_project
  region        = var.gcp_region
  zone          = var.gcp_zone
  mgmt_cidr     = "10.1.10.0/24"
  external_cidr = "10.1.20.0/24"
  internal_cidr = "10.1.30.0/24"
}

/*
module "servers" {
  source                = "./modules/servers"
  project           = "${var.gcp_project}"
  region            = "${var.gcp_region}"
  zone              = "${var.gcp_zone}"

  ssh_user          = "vmg"
  private-key-path  = "~/.ssh/id_rsa"

  external_count        = 1
  external_machine_type   = "n1-standard-2"
  external_boot_disk_size = "50"
  external_boot_disk_type = "pd-ssd"

  internal_count      = 1
  internal_machine_type   = "n1-standard-2"
  internal_boot_disk_size = "50"
  internal_boot_disk_type = "pd-ssd"
}
*/
