# AZ204-DadJokes
Project created in purpose to learn some things needed to pass  AZ-204 exam

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



az ad sp create-for-rbac --name DadJokesRG-ServicePrincipal --role reader --scopes /subscriptions/7807bc5e-0702-4fce-bd01-5fae8b54746e/resourceGroups/az204-dadjokes-rg
```

