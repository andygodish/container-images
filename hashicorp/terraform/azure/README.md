# Terraform/Azure

Terraform base images pulled from dockerhub with Azure CLI installed. 

The tf base image is built on Apline Linux. The Microsoft documentation does not contain an approved installation method for Alpine. I was able to follow the instructions outlined on this [github issue](https://github.com/Azure/azure-cli/issues/19591) to get the AZ CLI installed. It required pip/python as well. 