# Azure End-to-End DevOps 

An End-to-End azure implementation for DevOps 

## Features

- **Pure Azure Implementation**: Using official Azure
- **Azure Monitoring**: Azure Dashboard for monitoring
- **Azure Alert**: Azure dedicated alerting
- **GitHub Action**: Using GitHub Action CI/CD 

## Architecture

[Architecture](./docs/assets/architecture.png)
*(See [Architecture Docs](./docs/architecture.md) for details)*

## Tech Stack

- **Docker**: Dockerizing app
- **Nginx**: Using Nginx web server
- **Terraform**: For IaC
- **Bash**: For Scripting

## Setup Instructions

#### **Step 1: Get the Code**
**Fork** or **Clone** this repository to your GitHub account.

#### **Step 2: Configure GitHub Repository**
1. **Get a Secret**:
    - See [StackOverflow](https://stackoverflow.com/questions/57849090/where-to-find-the-values-to-subscription-id-client-id-secret-and-tenant-id) to get `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID`, and `AZURE_TENANT_ID`.

2. **Add a Secret**:
    - In your GitHub repository, go to `Settings` > `Secrets and variables` > `Actions`.
    - Click `New repository secret`.
    - Add secret `AZURE_CLIENT_ID`, `AZURE_SUBSCRIPTION_ID`, and `AZURE_TENANT_ID`.

#### **Step 3: Configure Variables**
In **[Workflows](./.github/workflows/)** and **[Backend.tf](./terraform/backend.tf)** replace the terraform variable with your own.

#### **Step 4: Run Workflows**
Push changes to run GitHub Actions

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
