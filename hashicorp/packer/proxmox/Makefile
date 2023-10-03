proxmox_storage_pool = 

.PHONY: rocky9 rocky9-debug

rocky9:
	packer init rocky9/packer.pkr.hcl
	packer build -var-file variables.pkrvars.hcl rocky9/packer.pkr.hcl

rocky9-debug:
	packer init rocky9/packer.pkr.hcl
	PACKER_LOG=1 PACKER_LOG_TIMESTAMP=1 packer build -var-file variables.pkrvars.hcl rocky9/packer.pkr.hcl