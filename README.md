# IaC automation using GitHub Actions and Terraform

[![CD](https://github.com/mohamedkdidi/terraform-github-actions/actions/workflows/terraform_cli.yml/badge.svg?branch=main)](https://github.com/mohamedkdidi/terraform-github-actions/actions/workflows/terraform_cli.yml)

Using GitHub Actions and Terraform to achieve an automated 'Infrastructure as Code' (IaC) workflow helps to reduce the possibility of human error and ensures our deployment time is kept minimal.


### Service Principal

To deploy the resources via GitHub Action first we need a service principal which will be used to authenticate into azure subscription from the workflow.

login to azure CLI using your azure account and create service principal.

Create service principal and assign contributor access on subscription (make sure you have access for role assignment and spn creation)

az ad sp create-for-rbac --name "service-principal-github-terraform" --role contributor --scopes /subscriptions/[subscriptionid] --sdk-auth

Then use the outcome of above azure cli query to create the secrets into the Repos. under the settings section of your repository

Add following secrets with following values in it:

```
AZURE_AD_CLIENT_ID: client id value of your service principal

AZURE_AD_CLIENT_SECRET: client secret value of your service principal

AZURE_SUBSCRIPTION_ID: subscription id value of your service principal

AZURE_AD_TENANT_ID: tenant id value of your service principal
```

## Using Terraform CLI

## Using Terraform Cloud

Set the client id and client secret using environment variables in Terraform cloud:

```
ARM_CLIENT_ID

ARM_CLIENT_SECRET

ARM_TENANT_ID

ARM_SUBSCRIPTION_ID
```


