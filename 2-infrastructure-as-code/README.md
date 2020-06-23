
## Switching environments

terraform workspace select [development / staging / production]

## terraform init

- Environments
    1. development
        - terraform init -input=false --backend-config=configs/development.hcl

    2. staging
        - terraform init -input=false --backend-config=configs/staging.hcl

    3. production
        - terraform init -input=false --backend-config=configs/production.hcl

## terraform plan

- Environments
    1. development
        - terraform plan -input=false -state=states/development.tfstate -var-file=vars/development.tfvars

    2. staging
        - terraform plan -input=false -state=states/staging.tfstate -var-file=vars/staging.tfvars

    3. production
        - terraform plan -input=false -state=states/production.tfstate -var-file=vars/production.tfvars

### terraform apply

- Environments
    1. development
        - terraform apply -input=false -state=states/development.tfstate -var-file=vars/development.tfvars

    2. staging
        - terraform apply -input=false -state=states/staging.tfstate -var-file=vars/staging.tfvars

    3. production
        - terraform apply -input=false -state=states/production.tfstate -var-file=vars/production.tfvars

## terraform destroy

- Environments
    1. development
        - terraform destroy -state=states/development.tfstate -var-file=vars/development.tfvars

    2. staging
        - terraform destroy -state=states/staging.tfstate -var-file=vars/staging.tfvars

    3. production
        - terraform destroy -state=states/production.tfstate -var-file=vars/production.tfvars


