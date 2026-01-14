graph TD
    User[Developer] -->|Push Code| GH[GitHub Actions]
    
    subgraph CI_CD [CI/CD Pipeline]
        GH -->|Terraform Apply| AzureInfra[Azure Resources]
        GH -->|Docker Build| Image[Docker Image]
        Image -->|Push| ACR[Azure Container Registry]
    end

    subgraph Azure_Cloud [Azure Environment]
        ACR -->|Docker Pull| VM[Linux VM]
        AzureInfra --> VM
        AzureInfra --> AppInsights[Application Insights]
        AzureInfra --> LAW[Log Analytics Workspace]
        
        VM -->|System Logs| LAW
        AppInsights -->|Store Data| LAW
    end

    subgraph End_User_Experience
        Client[User Browser] -->|HTTP Request| VM
        Client -->|JS Telemetry| AppInsights
    end
