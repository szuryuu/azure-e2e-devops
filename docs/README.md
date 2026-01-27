# Azure End-to-End DevOps 

An End-to-End azure implementation for DevOps, focusing on automation, security, and observability.

## Features

-   **Infrastructure as Code (IaC) & Configuration**  
    Fully automated provisioning using **Terraform** modules (Compute, Network, Monitoring) and **Cloud-Init**. Ensures environments are reproducible, immutable, and free from configuration drift.

-   **Automated DevOps Pipeline**  
    End-to-end **GitHub Actions** workflow that enforces quality and security at every stage: Linting (**ESLint**), Infrastructure Planning, Container Vulnerability Scanning (**Trivy**), and Automated Smoke Testing post-deployment.

-   **Enterprise-Grade Security**  
    Built-in hardening with **Azure Key Vault** for secret management (no hardcoded credentials), **Managed Identity** (RBAC) for secure resource access, and strict **Network Security Groups** to minimize attack surface.

-   **Full-Stack Observability**  
    Integrated monitoring ecosystem using **Azure Monitor** and **Log Analytics**. Includes custom Dashboards for real-time visualization and **Action Groups** for automated alerting on critical system metrics (CPU, HTTP Errors).

## Architecture

![Architecture](https://raw.githubusercontent.com/szuryuu/azure-e2e-devops/main/docs/assets/architecture-diagram.png)
*(See [Architecture Docs](./architecture.md) for details)*

## Tech Stack

| Category | Technologies |
| :--- | :--- |
| **Cloud Provider** | Microsoft Azure (VM, VNET, ACR, Key Vault, Monitor) |
| **Infrastructure** | Terraform (HCL), Cloud-Init |
| **Containerization** | Docker, Nginx (Alpine) |
| **CI/CD** | GitHub Actions |
| **Security** | Trivy, Azure Managed Identity, Azure Key Vault |
| **Observability** | Azure Application Insights, Log Analytics, Azure Monitor |
| **Scripting** | Bash (Automation & Testing) |

## Setup Instructions

#### **Step 1: Get the Code**
**Fork** or **Clone** this repository to your GitHub account.

#### **Step 2: Configure Azure Credentials**
1.  **Obtain Credentials**  
    Since this requires a Service Principal, please refer to the official documentation on how to generate these credentials or request them from your Azure Administrator:
    * [Microsoft Docs: Connect GitHub Actions to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#create-a-service-principal-and-add-it-as-a-github-secret)

2.  **Add Secrets to GitHub**   
    In your repository, navigate to **Settings** > **Secrets and variables** > **Actions** > **New repository secret**. Add the following secrets:
    * `AZURE_CLIENT_ID`
    * `AZURE_CLIENT_SECRET`
    * `AZURE_SUBSCRIPTION_ID`
    * `AZURE_TENANT_ID`

#### **Step 3: Configure Variables**
1.  **Backend Configuration**  
    Edit `terraform/backend.tf` to match your existing Azure Storage Account (used for storing Terraform state):
    ```hcl
    resource_group_name  = "<YOUR_RESOURCE_GROUP>"
    storage_account_name = "<YOUR_STORAGE_ACCOUNT>"
    container_name       = "<YOUR_CONTAINER_NAME>"
    key                  = "terraform.tfstate"
    ```

2.  **Environment Variables**  
    Check `.github/workflows/main.yml` and update the environment variables (under `env:`) to match your project details (Resource Group name, Location, etc.).

#### **Step 4: Deploy**
1.  Navigate to the **Actions** tab in your repository.
2.  Select the **Deploy to Azure** workflow.
3.  Click **Run workflow** (or simply push a commit to the `main` branch).
4.  Wait for the pipeline to complete. The workflow will output the VM Public IP.

#### **Step 5: Verify Deployment**
-   **Web App**  
    Visit `http://<VM_PUBLIC_IP>` to see the deployed application.
-   **Monitoring**  
    Go to the `Azure Portal`, find the created Dashboard, and view live metrics.
-   **Logs**  
    Check the `Log Analytics Workspace` to query Nginx access logs.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
