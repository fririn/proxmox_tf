terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.77.1"
    }
  }
}

# provider "proxmox" {
#   password = "Oshmkufa-2010-proxmox"
#   username = "root@pam"
#   ssh {
#     agent       = true
#     private_key = file("/home/paul/.ssh/id_rsa")
#     username    = "root"
#   }
# }

provider "proxmox" {
  endpoint = var.proxmox_api_url
  ssh {
    agent = false
  }
}




resource "proxmox_virtual_environment_vm" "master" {
  count       = var.master_count
  name        = "k8s-master-${count.index}"
  description = "Kubernetes master node ${count.index}"
  node_name   = var.proxmox_node
  tags        = ["k8s", "terraform", "master"]

  # Clone from template
  clone {
    vm_id = proxmox_virtual_environment_vm.k8s_template.id
    full  = true
  }

  # Hardware specs
  cpu {
    cores = var.master_cpu
    type  = "host"
  }
  memory {
    dedicated = var.master_memory
  }

  disk {
    datastore_id = var.template_storage
    interface    = "scsi0"
    size         = var.master_disk_size
  }

  # Static IP configuration
  initialization {
    datastore_id = var.template_storage

    user_account {
      username = "ubuntu"
      keys     = [var.ssh_public_key]
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
  depends_on = [proxmox_virtual_environment_vm.k8s_template]
}

resource "proxmox_virtual_environment_vm" "worker" {
  count       = var.worker_count
  name        = "k8s-worker-${count.index}"
  description = "Kubernetes worker node ${count.index}"
  node_name   = var.proxmox_node
  tags        = ["k8s", "terraform", "worker"]

  # Clone from template
  clone {
    vm_id = proxmox_virtual_environment_vm.k8s_template.id
    full  = true
  }

  # Hardware specs
  cpu {
    cores = var.worker_cpu
    type  = "host"
  }

  memory {
    dedicated = var.worker_memory
  }

  disk {
    datastore_id = var.template_storage
    interface    = "scsi0"
    size         = var.worker_disk_size
  }

  # Static IP configuration
  initialization {
    datastore_id = var.template_storage

    user_account {
      username = "ubuntu"
      keys     = [var.ssh_public_key]
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
  depends_on = [proxmox_virtual_environment_vm.k8s_template]
}

