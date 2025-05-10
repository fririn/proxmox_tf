variable "cluster" {
  description = "Kubernetes cluster configuration"
  type = object({
    os_image = string

    master_count = number
    master_cpu   = number
    master_ram   = number

    worker_count = number
    worker_cpu   = number
    worker_ram   = number

    ssh_keys = list(string)
  })
  default = {
    os_image = "ubuntu-2404-cloudimg"

    master_count = 1
    master_cpu   = 2
    master_ram   = 2048

    worker_count = 1
    worker_cpu   = 1
    worker_ram   = 1024

    ssh_keys = ["ssh-rsa AAAAB3N... user@host"]
  }
}

