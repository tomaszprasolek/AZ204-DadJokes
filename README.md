# AZ204-DadJokes
Project created in purpose to learn some things needed to pass AZ-204 exam

![Azure resources diagram](.\DadJokes Azure Diagram.drawio.png)

## How to set up all environemnt with all Azure resources

1. Create resource group when all other Azure resource will be placed
2. Get your principal identifier from Azure, it is needed for the next script. You can find it: Users >> your user >> Object Id. It is need to add your user the `Contributor` role to Azure Container Registry (ACR).
3. Run `main.bicep` script (AZ204-DadJokes/Bicep/main.bicep) and pass `Object Id` as parameter.
4. Command to run Bicep script: `az deployment group create --resource-group rg-Dadjokes-ne --template-file .\AZ204-DadJokes\Bicep\main.bicep --parameters parPrincipalId='your-object-id'`. **Remember changing the resource group name and principal id.**
5. In that moment you should have **Azure Container Registry created on the Azure**.
6. Copy password from ACR (ACR >> Settings >> Access Keys >> password) to Github repository secrets (Settings >> Security >> Secret and variables >> Actions) to `ACR_PASSWORD` field.
7. Run command `az ad sp create-for-rbac --name DadJokesRG-ServicePrincipal --role contributor --scopes /subscriptions/#your-subsciption-guid#/resourceGroups/rg-Dadjokes-ne --sdk-auth`. This command will generate the JSON with credentials to the Azure. You need this to able Github to login into Azure.
   
  1. Scope you get from your resource group, click `JSON view` in Overview tab and the `id` field it will be that scope.
  2. The generated JSON you need to copy to Github repository secrets (Settings >> Security >> Secret and variables >> Actions) to `AZURE_CREDENTIALS_V2`
9. Now you can publish docker image to Azure Container Registry. There are 2 options:  
    
    6. Push new tag to your Git repository, this will trigger the Github Action which publish docker image to ACR.
    7. Run `AZ204-DadJokes/Bicep/containerInstance.bicep` script. This script requires 2 parameters: environment type and version.
    8. 

## Links:

Azure Container Registry:
- https://brendanthompson.com/posts/2022/02/using-github-actions-to-publish-container-images-to-azure-container-registry
- https://thomasthornton.cloud/2022/12/14/build-and-push-docker-image-to-azure-container-registry-using-github-action/

Portal Azure:
- https://learn.microsoft.com/en-us/answers/questions/1369827/(solved)-status-401-unauthorized-shows-in-the-repo
- https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-service-principal
- https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1?tabs=bash

Github Actions:
- https://github.com/marketplace/actions/get-latest-tag
- https://github.com/actions/runner/issues/1413#issuecomment-1197936320

Azure Bicep links:
- https://www.youtube.com/watch?v=VDCAJIGqHZU&pp=ygULYXp1cmUgYmljZXA%3D
- https://www.youtube.com/watch?v=atWVFV7Y4vY
- https://johnlokerse.dev/2023/09/11/azure-bicep-tips-tricks/
- https://www.thorsten-hans.com/how-to-deploy-azure-container-apps-with-bicep/
- https://stackoverflow.com/questions/72044477/creating-container-registry-from-azure-bicep-and-deploying-image-to-this-registr
- https://www.serverlessnotes.com/docs/deploy-azure-container-apps-using-bicep

Azure Bicep commands:
```
// TODO: check this

// Create role assignment
resource registryRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid(subscription().subscriptionId, resourceGroup().name, registryName, roleId, principalId)
  scope: acr
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleId)
    principalId: principalId
  }
}
```

Azure Commands
```
az container create \
    --resource-group az204-dadjokes-rg \
    --name devdadjokes \
    --image acrdadjokespc.azurecr.io/dadjokes:v0.0.3
    --restart-policy OnFailure \
    --environment-variables 'RunningEnvironment'='dev_azure' \
    --ports 80 \
    --dns-name-label tomotest \



az container create --resource-group az204-dadjokes-rg --name devdadjokes --image acrdadjokespc.azurecr.io/dadjokes:v0.0.3 --restart-policy OnFailure --environment-variables RunningEnvironment=dev_azure --ports 80 --dns-name-label tomodadjokes --registry-username SECRET --registry-password SECRET


az ad sp create-for-rbac --name DadJokesRG-ServicePrincipal --role contributor --scopes /subscriptions/7807bc5e-0702-4fce-bd01-5fae8b54746e/resourceGroups/az204-dadjokes-rg --sdk-auth


az ad sp create-for-rbac --name DadJokesRG-ServicePrincipal-V2 --role contributor --scopes /subscriptions/7807bc5e-0702-4fce-bd01-5fae8b54746e/resourceGroups/rg-Dadjokes-ne --sdk-auth


az deployment group create --resource-group rg-Dadjokes-ne --template-file containerApps.bicep --parameters parVersion='v0.0.16'


az containerapp env create --name acaEnvDadjokesNe --resource-group rg-Dadjokes-ne --location northeurope


az deployment group create --resource-group rg-Dadjokes-ne --template-file .\AZ204-DadJokes\Bicep\ContainerApps\main.bicep --parameters parVersion='v0.0.19'


```
