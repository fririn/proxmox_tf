terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.77.1"
    }
  }
}

provider "proxmox" {
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
  vm_id       = var.base_master_vm_id + count.index

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

  depends_on = [proxmox_virtual_environment_vm.k8s_template]
}

resource "proxmox_virtual_environment_vm" "worker" {
  count       = var.worker_count
  name        = "k8s-worker-${count.index}"
  description = "Kubernetes worker node ${count.index}"
  node_name   = var.proxmox_node
  tags        = ["k8s", "terraform", "worker"]
  vm_id       = var.base_worker_vm_id + count.index

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

  depends_on = [proxmox_virtual_environment_vm.k8s_template]
}




# Outputs
output "k8s_master_details" {
  description = "Details of Kubernetes master nodes"
  value = [
    for vm in proxmox_virtual_environment_vm.master : {
      name  = vm.name
      vm_id = vm.vm_id
      ip    = vm.ipv4_addresses[1][0]
    }
  ]
}

output "k8s_worker_details" {
  description = "Details of Kubernetes worker nodes"
  value = [
    for vm in proxmox_virtual_environment_vm.worker : {
      name  = vm.name
      vm_id = vm.vm_id
      ip    = vm.ipv4_addresses[1][0]
    }
  ]
}

output "ansible_command" {
  description = "Command to run Ansible playbook"
  value       = "cd ansible && ansible-playbook -i inventory.ini site.yml"
}
