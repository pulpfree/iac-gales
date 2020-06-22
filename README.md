# Webbtech Terraform Cloud Infrastructure

## Plan & Deploy Commands

```bash
# stage environment
terraform plan -var-file=stage.tfvars
terraform apply -var-file=stage.tfvars

# production environment
terraform plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars
```

When deploying gsales-client, ensure that the 'locals'  object is switched between environments, i.e.: stage and prod
