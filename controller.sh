#!/bin/bash

mode=$1

export $(head -n 1 secrets/.env)
export $(tail -n 1 secrets/.env)

ssh_config_file="$HOME/.ssh"
bastion_alias="bastion-host"

case ${mode} in 

    apply)
        cd environments/network
        terraform init
        terraform plan
        terraform apply --auto-approve
        cd ../vms
        terraform init
        terraform plan
        terraform apply --auto-approve
        
        #? ADD IP extenral host to ssh config fiel
        bastion_ip=$(terraform output -json nat_ip_addresses | jq -r '.["fable-instance-external-nat"]')
        sed -i '' -E "/^Host fable-bastion-host/{
            n
            s#^([[:space:]]*Hostname[[:space:]]).*#\1${bastion_ip}#
        }" "${ssh_config_file}/config" 
        ;;

    destroy)
        cd environments/vms
        terraform init
        terraform plan
        terraform destroy --auto-approve
        cd ../network
        terraform init
        terraform plan
        terraform destroy --auto-approve

        #? Clean up
        echo "" > "${ssh_config_file}/known_hosts_instances"
        ;;

    ssh)
        cd environments/vms
        bastion_ip=$(terraform output -json nat_ip_addresses | jq -r '.["fable-instance-external-nat"]')
        sed -i '' -E "/^Host fable-bastion-host/{
            n
            s#^([[:space:]]*Hostname[[:space:]]).*#\1${bastion_ip}#
        }" "${ssh_config_file}/config" 
        ;;
esac