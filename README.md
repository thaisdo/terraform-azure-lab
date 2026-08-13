# Terraform Azure Lab

A small Infrastructure as Code (IaC) project built with Terraform and Microsoft Azure.

This project was created as a hands-on laboratory to understand the fundamentals of Terraform, Azure resource provisioning, Terraform State, resource dependencies, and infrastructure lifecycle management.

The infrastructure represents a simplified Azure data lake environment.

## Objective

The main goal of this project is to learn Terraform by provisioning and managing real Azure resources instead of only working with theoretical examples.

Throughout the project, the infrastructure was created, modified, refactored, and validated using Terraform.

## Architecture

```text
Azure Subscription
│
└── Resource Group
    │
    └── Storage Account
        │
        ├── bronze
        ├── silver
        └── gold
```

## Technologies

- Terraform
- Microsoft Azure
- AzureRM Provider
- PowerShell

## Infrastructure

The current infrastructure consists of:

### Resource Group

```text
rg-terraform-lab
```

The Resource Group contains the Azure resources managed by Terraform.

### Storage Account

```text
stterraformlabthai
```

A general-purpose Azure Storage Account used as the foundation for the laboratory data lake.

### Blob Containers

Three private containers were created to represent common data lake layers:

```text
bronze
silver
gold
```

These layers are only a simplified representation for educational purposes.

## Terraform Concepts Practiced

### Providers

Configured the AzureRM provider to allow Terraform to communicate with Microsoft Azure.

### Resources

Created Azure infrastructure using Terraform resource blocks.

Examples:

```hcl
resource "azurerm_resource_group" "lab" {
  ...
}

resource "azurerm_storage_account" "data_lake" {
  ...
}

resource "azurerm_storage_container" "data_lake" {
  ...
}
```

### Variables

Defined reusable configuration values using `variables.tf`.

Examples include:

- Resource Group name
- Azure location
- Environment
- Project name
- Storage Account name
- Storage containers

### Variable Defaults

Used default values for variables when no explicit value is provided.

```hcl
variable "environment" {
  type    = string
  default = "dev"
}
```

Explicit values can be provided through `terraform.tfvars`.

### `terraform.tfvars`

Used a local variable file to provide environment-specific configuration.

Sensitive or local configuration files are excluded from version control.

### Outputs

Created Terraform outputs to expose useful information after provisioning.

Examples:

- Resource Group name
- Resource Group location
- Resource Group ID
- Storage Account name
- Storage Account ID

### Terraform State

Worked directly with Terraform State to understand how Terraform tracks the relationship between configuration and real infrastructure.

The project also demonstrated how changing a resource's Terraform address can affect the plan.

### `terraform plan`

Used `terraform plan` to preview infrastructure changes before applying them.

The project covered:

```text
+ create
~ update in-place
- destroy
-/+ destroy and recreate
```

### `terraform apply`

Used `terraform apply` to provision and update real Azure infrastructure.

### Idempotency

Validated that running:

```bash
terraform plan
```

after the infrastructure was synchronized results in:

```text
No changes. Your infrastructure matches the configuration.
```

### Resource Replacement

Changed a Resource Group property that required replacement and observed Terraform planning:

```text
-/+ destroy and then create replacement
```

This demonstrated the importance of reviewing `terraform plan` before applying changes.

### Resource Dependencies

Created dependencies between Azure resources through Terraform references.

For example:

```hcl
resource_group_name = azurerm_resource_group.lab.name
```

and:

```hcl
storage_account_id = azurerm_storage_account.data_lake.id
```

Terraform can therefore determine the relationship and provisioning order between resources.

### `for_each`

Refactored three independently declared storage containers into a single reusable resource definition:

```hcl
resource "azurerm_storage_container" "data_lake" {
  for_each = var.storage_containers

  name                  = each.value
  storage_account_id    = azurerm_storage_account.data_lake.id
  container_access_type = "private"
}
```

This allows the infrastructure to scale by changing the collection of containers rather than duplicating resource blocks.

### Terraform State Migration

After introducing `for_each`, Terraform initially interpreted the containers as new resources because their resource addresses changed.

The state was migrated using:

```bash
terraform state mv
```

For example:

```text
azurerm_storage_container.bronze
```

was moved to:

```text
azurerm_storage_container.data_lake["bronze"]
```

This allowed the existing Azure resources to remain untouched while updating their Terraform addresses.

## Project Structure

```text
terraform-azure-lab/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── containers.tf
├── terraform.tfvars.example
├── .gitignore
├── .terraform.lock.hcl
└── README.md
```

### File responsibilities

| File | Purpose |
|---|---|
| `main.tf` | Main Azure resources |
| `variables.tf` | Terraform variable definitions |
| `outputs.tf` | Values exposed after deployment |
| `containers.tf` | Storage container resources |
| `terraform.tfvars.example` | Example configuration |
| `.gitignore` | Prevents local/state files from being committed |
| `.terraform.lock.hcl` | Locks provider versions |
| `README.md` | Project documentation |

## Security and Version Control

Terraform State and local variable files are intentionally excluded from Git.

The following files should **not** be committed:

```text
terraform.tfstate
terraform.tfstate.backup
terraform.tfvars
.terraform/
```

The repository contains `terraform.tfvars.example` as a safe configuration template.

## Important Note

This project is an educational laboratory.

The infrastructure configuration is intentionally simple and should not be considered a production-ready Azure data lake architecture.

Production environments would require additional considerations such as:

- Remote Terraform State
- State locking
- Identity and access management
- Network security
- Private endpoints
- Secrets management
- Encryption policies
- Azure Policy
- Resource locks
- Monitoring
- Cost management
- Environment separation
- CI/CD

## What I Learned

This laboratory provided hands-on experience with the Terraform infrastructure lifecycle:

```text
Write configuration
       ↓
terraform init
       ↓
terraform validate
       ↓
terraform plan
       ↓
terraform apply
       ↓
Azure infrastructure
       ↓
terraform plan
       ↓
No changes
```

It also demonstrated an important principle of Infrastructure as Code:

> Terraform is not simply a tool for creating infrastructure. It continuously compares the desired configuration with the real infrastructure and manages the difference between them.