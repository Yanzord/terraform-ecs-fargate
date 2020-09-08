#!/bin/bash

environment=$1
region=$2
bucket=$3

terraform init \
--backend-config="bucket=${bucket}" \
--backend-config="key=${environment}/ecs-test-state" \
--backend-config="region=${region}"

terraform destroy -auto-approve -parallelism=3 \
-var "region=${region}"