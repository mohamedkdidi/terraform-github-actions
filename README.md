# IaC automation using GitHub Actions and Terraform

[![Terraform CLI](https://github.com/mohamedkdidi/terraform-github-actions/actions/workflows/terraform_cli.yml/badge.svg)](https://github.com/mohamedkdidi/terraform-github-actions/actions/workflows/terraform_cli.yml)

[![Terraform Cloud](https://github.com/mohamedkdidi/terraform-github-actions/actions/workflows/terraform_cloud.yml/badge.svg)](https://github.com/mohamedkdidi/terraform-github-actions/actions/workflows/terraform_cloud.yml) 

Using GitHub Actions and Terraform to achieve an automated 'Infrastructure as Code' (IaC) workflow helps to reduce the possibility of human error and ensures our deployment time is kept minimal.


### Service Principal

To deploy the resources via GitHub Action first we need a service principal which will be used to authenticate into azure subscription from the workflow.

login to azure CLI using your azure account and create service principal.

Create service principal and assign contributor access on subscription (make sure you have access for role assignment and spn creation)

az ad sp create-for-rbac --name "service-principal-github-terraform" --role contributor --scopes /subscriptions/[subscriptionid] --sdk-auth

Then use the outcome of above azure cli query to create the secrets into the Repos for pipeline with Terraform CLI or in Terraform Cloud for the pipeline with Terraform Cloud.



## Using Terraform CLI

Under the settings section of your repository add following secrets:

```
AZURE_AD_CLIENT_ID:

AZURE_AD_CLIENT_SECRET:

AZURE_SUBSCRIPTION_ID:

AZURE_AD_TENANT_ID:
```

## Using Terraform Cloud

Set the client id and client secret using environment variables in Terraform cloud:

```
ARM_CLIENT_ID

ARM_CLIENT_SECRET

ARM_TENANT_ID

ARM_SUBSCRIPTION_ID
```

In Terraform cloud interface generate API token, then set this token in Github secret with name 
```
TERRAFORM_API_TOKEN
```