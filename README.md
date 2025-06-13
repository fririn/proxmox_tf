##fooling around with terraform to provision a k8s cluster on my Proxmox hv. very much wip.

Terraform creates the machines and installs qemu agents, and generates ansible inventory.
Then Ansible configures the cluster (this is wip currently)

to run - populate .env_template with your proxmox credentials, populate tfvars and then run "source .env_template" + "tf apply -var-file="variables.tfvars"

the result should be ubuntu template, n master and n worker nodes provided in proxmox. 
