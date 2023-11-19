# AZ204-DadJokes
Project created in purpose to learn some things needed to pass AZ-204 exam

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



az ad sp create-for-rbac --name DadJokesRG-ServicePrincipal --role contributor --scopes /subscriptions/***REMOVED***/resourceGroups/az204-dadjokes-rg --sdk-auth


az ad sp create-for-rbac --name DadJokesRG-ServicePrincipal-V2 --role contributor --scopes /subscriptions/***REMOVED***/resourceGroups/rg-Dadjokes-ne --sdk-auth


az deployment group create --resource-group rg-Dadjokes-ne --template-file containerApps.bicep --parameters parVersion='v0.0.16'


az containerapp env create --name acaEnvDadjokesNe --resource-group rg-Dadjokes-ne --location northeurope
```

