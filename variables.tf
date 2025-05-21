variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type        = string
}

variable "proxmox_username" {
  description = "Proxmox API username"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox API password"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Skip TLS verification"
  type        = bool
  default     = true
}

variable "proxmox_ssh_user" {
  description = "SSH username for Proxmox host"
  type        = string
  default     = "root"
}

variable "proxmox_node" {
  description = "The Proxmox node to deploy VMs on"
  type        = string
}

variable "template_name" {
  description = "Name for the Ubuntu Cloud-Init template"
  type        = string
  default     = "ubuntu-cloud-template"
}

variable "template_storage" {
  description = "Storage location for template"
  type        = string
  default     = "local"
}

variable "image_storage" {
  description = "Storage location for image"
  type        = string
  default     = "local"
}

variable "ubuntu_cloud_image_url" {
  description = "URL for Ubuntu Cloud Image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "network_bridge" {
  description = "Network bridge for VM network interfaces"
  type        = string
  default     = "vmbr0"
}

variable "master_count" {
  description = "Number of Kubernetes master nodes"
  type        = number
  default     = 1
}

variable "master_cpu" {
  description = "Number of CPU cores for master nodes"
  type        = number
  default     = 2
}

variable "master_memory" {
  description = "Memory in MB for master nodes"
  type        = number
  default     = 4096
}

variable "master_disk_size" {
  description = "Disk size in GB for master nodes"
  type        = string
  default     = "20G"
}

variable "worker_count" {
  description = "Number of Kubernetes worker nodes"
  type        = number
  default     = 2
}

variable "worker_cpu" {
  description = "Number of CPU cores for worker nodes"
  type        = number
  default     = 4
}

variable "worker_memory" {
  description = "Memory in MB for worker nodes"
  type        = number
  default     = 8192
}

variable "worker_disk_size" {
  description = "Disk size in GB for worker nodes"
  type        = string
  default     = "40G"
}

# Local variables
locals {
  vm_defaults = {
    clone    = var.template_name
    os_type  = "cloud-init"
    agent    = 1
    bootdisk = "scsi0"
    scsihw   = "virtio-scsi-pci"
  }
}

