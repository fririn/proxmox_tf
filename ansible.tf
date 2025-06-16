resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    master_nodes = [
      for i, vm in proxmox_virtual_environment_vm.master : {
        name  = vm.name
        ip    = vm.ipv4_addresses[1][0]
        vm_id = vm.vm_id
      }
    ]
    worker_nodes = [
      for i, vm in proxmox_virtual_environment_vm.worker : {
        name  = vm.name
        ip    = vm.ipv4_addresses[1][0]
        vm_id = vm.vm_id
      }
    ]
    ansible_user = var.vm_ssh_user
    ssh_key      = var.ssh_private_key_file
  })

  filename = "${path.module}/ansible/inventory.ini"

  depends_on = [
    proxmox_virtual_environment_vm.master,
    proxmox_virtual_environment_vm.worker
  ]
}

