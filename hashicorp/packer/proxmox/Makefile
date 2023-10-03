proxmox_storage_pool = 

.PHONY: rocky9

rocky9:
	packer init rocky9/packer.pkr.hcl
	packer build -var-file variables.pkrvars.hcl rocky9/packer.pkr.hcl