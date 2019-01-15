#####################################################################
##
##      Created 15/01/2019 by admin.
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "vsphere" {
  user           = "${var.user}"
  password       = "${var.password}"
  vsphere_server = "${var.vsphere_server}"

  allow_unverified_ssl = "${var.allow_unverified_ssl}"
  version = "~> 1.2"
}

variable "user" {
  type = "string"
  description = "Generated"
}

variable "password" {
  type = "string"
  description = "Generated"
}

variable "vsphere_server" {
  type = "string"
  description = "Generated"
}

variable "allow_unverified_ssl" {
  type = "string"
  description = "Generated"
}

variable "vm1_name" {
  type = "string"
  description = "Virtual machine name for vm1"
}

variable "vm1_number_of_vcpu" {
  type = "string"
  description = "Number of virtual cpu's."
}

variable "vm1_memory" {
  type = "string"
  description = "Memory allocation."
}

variable "vm1_disk_name" {
  type = "string"
  description = "The name of the disk. Forces a new disk if changed. This should only be a longer path if attaching an external disk."
}

variable "vm1_disk_size" {
  type = "string"
  description = "The size of the disk, in GiB."
}

variable "vm1_template_name" {
  type = "string"
  description = "Generated"
}

variable "vm1_datacenter_name" {
  type = "string"
  description = "Generated"
}

variable "vm1_datastore_name" {
  type = "string"
  description = "Generated"
}

variable "vm1_resource_pool" {
  type = "string"
  description = "Resource pool."
}


data "vsphere_virtual_machine" "vm1_template" {
  name          = "${var.vm1_template_name}"
  datacenter_id = "${data.vsphere_datacenter.vm1_datacenter.id}"
}

data "vsphere_datacenter" "vm1_datacenter" {
  name = "${var.vm1_datacenter_name}"
}

data "vsphere_datastore" "vm1_datastore" {
  name          = "${var.vm1_datastore_name}"
  datacenter_id = "${data.vsphere_datacenter.vm1_datacenter.id}"
}

resource "vsphere_virtual_machine" "vm1" {
  name = "${var.vm1_memory}"
  datastore_id  = "${data.vsphere_datastore.vm1_datastore.id}"
  num_cpus      = "${var.vm1_number_of_vcpu}"
  memory        = "${var.vm1_memory}"
  guest_id = "${data.vsphere_virtual_machine.vm1_template.guest_id}"
  resource_pool_id = "${var.vm1_resource_pool}"
  clone {
    template_uuid = "${data.vsphere_virtual_machine.vm1_template.id}"
  }
  disk {
    name = "${var.vm1_disk_name}"
    size = "${var.vm1_disk_size}"
  }
}