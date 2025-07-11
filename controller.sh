#!/bin/bash

mode=$1

export $(head -n 1 secrets/.env)
export $(tail -n 1 secrets/.env)


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
        ;;
esac