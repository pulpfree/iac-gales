# Webbtech Terraform Cloud Infrastructure

## Deploy Commands

```bash
# plan
terraform plan -var-file=stage.tfvars
terraform apply -var-file=stage.tfvars
```

When deploying gsales-client, ensure that the 'locals'  object is switched between environments, i.e.: stage and prod
