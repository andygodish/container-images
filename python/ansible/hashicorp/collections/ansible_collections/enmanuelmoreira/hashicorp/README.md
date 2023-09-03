# Ansible Collection: Hashicorp

[![pipeline status](https://gitlab.com/enmanuelmoreira/ansible-collection-hashicorp/badges/main/pipeline.svg)](https://gitlab.com/enmanuelmoreira/ansible-collection-hashicorp/-/commits/main)
[![Galaxy Collection][badge-collection]][link-galaxy]

This role installs a set of tools from Hashicorp.

## Requirements

None.

## Installation

Install via Ansible Galaxy:

```bash
ansible-galaxy collection install enmanuelmoreira.hashicorp
```

Or include this collection in your playbook's requirements.yml file:

```bash
---
collections:
  - name: enmanuelmoreira.hashicorp
```

You also can download the collection using the following commands:

```bash
git clone https://gitlab.com/enmanuelmoreira/ansible-collection-hashicorp
cd ansible-collection-hashicorp
git submodule update --init --recursive
```

You could modify the example playbook `playbook-example.yml` on the section roles to install the software as you wish.

And run the playbook:

```bash
ansible-playbook playbook-example.yml -K
```

## Hashicorp Tools Available

* [Terraform](https://terraform.io/): Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services.  
* [Packer](https://packer.io/): Packer is a free and open source tool for creating golden images for multiple platforms from a single source configuration.  
* [Vagrant](https://vagrantup.com):  HashiCorp Vagrant provides the same, easy workflow regardless of your role as a developer, operator, or designer.  

## Dependencies

None.

## Example Playbook

    - hosts: localhost
      gather_facts: yes
      become: yes

      vars_prompt:
        - name: github_token
          prompt: "What is your GitHub Token?"
          default: "{{ lookup('env','GITHUB_TOKEN') }}"
          private: yes
    
      roles:
        - terraform
        - vagrant
        - packer

## License

MIT / BSD

[link-galaxy]: https://galaxy.ansible.com/enmanuelmoreira/hashicorp
[badge-collection]: https://img.shields.io/badge/collection-enmanuelmoreira.hashicorp-blue
