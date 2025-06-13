variable "proxmox_node" {
  description = "The Proxmox node to deploy VMs on"
  type        = string
}

variable "template_name" {
  description = "Name for the Ubuntu Cloud-Init template"
  type        = string
  default     = "ubuntu-cloud-template"
}

variable "template_id" {
  description = "Id of the k8s template"
  type        = string
  default     = "5000"
}

variable "base_worker_vm_id" {
  description = "Base VM id in Proxmox"
  type        = string
  default     = "5010"
}

variable "base_master_vm_id" {
  description = "Base VM id in Proxmox"
  type        = string
  default     = "5020"
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

variable "cloud_image_url" {
  description = "URL for Ubuntu Cloud Image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "vm_ssh_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "ssh_private_key_file" {
  description = "Private key file location"
  type        = string
}

variable "vm_ssh_user" {
  description = "User for vms"
  type        = string
}

variable "vm_ssh_password" {
  description = "password for vms"
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
}

