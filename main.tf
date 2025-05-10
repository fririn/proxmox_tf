terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.77.1"
    }
  }
}

provider "proxmox" {
  # endpoint = "http://10.0.128.4:8006"
  # using variables from .env for setting up the provider
  ssh {
    agent = false
    #private_key = file("~/.ssh/id_rsa")
    node {
      name = "hv02"
      address = "10.0.128.4"
  }
}

# resource "proxmox_vm_qemu" "k8s_master" {
#   target_node = "hv02"
#   count       = var.cluster.master_count
#   name        = "master-${count.index + 1}"
#   vmid        = "60${count.index}"
#
#   os_type    = "cloud-init"
#   clone      = var.cluster.os_image
#   full_clone = true
#
#   ipconfig0 = "[gw=10.0.128.1,ip=10.0.128.6${count.index}/24]"
#
#   cores  = var.cluster.master_cpu
#   memory = var.cluster.master_ram
#   agent  = 1
#
#   tags = "k8s,terraform"
# }
#
# resource "proxmox_vm_qemu" "k8s_worker" {
#   target_node = "hv02"
#   count       = var.cluster.worker_count
#   name        = "worker-${count.index + 1}"
#   vmid        = "61${count.index}"
#
#   os_type    = "cloud-init"
#   clone      = var.cluster.os_image
#   full_clone = true
#
#   cores  = var.cluster.worker_cpu
#   memory = var.cluster.worker_ram
#   agent  = 1
#
#   ipconfig0 = "[gw=10.0.128.1,ip=10.0.128.7${count.index}/24]"
#   tags      = "k8s,terraform"
#
#   # Network
#   # network {
#   #   model  = "virtio"
#   #   bridge = "vmbr0"
#   # }
#
#   # Disk
#   # disk {
#   #   type    = "scsi"
#   #   storage = "local-lvm"
#   #   size    = "8G"
#   # }
# }
