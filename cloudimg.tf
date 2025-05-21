data "local_file" "ssh_public_key" {
  filename = "/home/paul/.ssh/id_rsa.pub"
}


resource "proxmox_virtual_environment_vm" "k8s_template" {
  name        = "k8s-template"
  node_name   = var.proxmox_node
  description = "this shit is hard smh"

  tags     = ["template", "terraform", "k8s"]
  vm_id    = 5000
  template = true
  started  = false

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 2048
  }

  agent {
    enabled = false
  }

  disk {
    datastore_id = var.template_storage
    file_id      = proxmox_virtual_environment_download_file.ubuntu2404_cloud_image.id
    interface    = "virtio0"
    discard      = "on"
    size         = 8
  }

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  initialization {
    datastore_id = var.template_storage
    user_account {
      username = "adm"
      password = "adm"
      keys     = [var.ssh_public_key]
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
  depends_on = [proxmox_virtual_environment_download_file.ubuntu2404_cloud_image]
}

resource "proxmox_virtual_environment_download_file" "ubuntu2404_cloud_image" {
  content_type = "iso"
  node_name    = var.proxmox_node
  datastore_id = var.image_storage
  url          = var.ubuntu_cloud_image_url
}




