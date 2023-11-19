@sys.description('Format: v0.0.0')
param parVersion string
param parLocation string = 'northeurope'

var varEnvironmentType = 'prod' 


resource resEnvironment 'Microsoft.App/managedEnvironments@2023-05-02-preview' existing = {
  name: 'acaEnvDadjokesNe'
}


resource resContainerRegistry 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' existing = {
  name: 'acrDadjokesPc'
}


resource resContainerApps 'Microsoft.App/containerApps@2023-05-02-preview' ={
  name: 'aca-dadjokes-ne'
  location: parLocation
  properties:{
    environmentId: resEnvironment.id
    configuration:{
      secrets:[
        {
          name: 'container-registry-password'
          value: resContainerRegistry.listCredentials().passwords[0].value
        }
      ]
      registries:[
        {
          server: resContainerRegistry.properties.loginServer
          username: resContainerRegistry.listCredentials().username
          passwordSecretRef: 'container-registry-password'
        }
      ]
      ingress:{
        external: true // check what is the default value
        targetPort: 80
      }
    }
    template:{
      containers:[
        {
          image: 'acrdadjokespc.azurecr.io/dadjokes:${parVersion}' // TODO: CR url should be in param
          name: '${varEnvironmentType}dadjokes'
          env: [
            {
              name: 'RunningEnvironment'
              value: 'azure-${varEnvironmentType}'
            }
            {
              name: 'VERSION'
              value: parVersion
            }
          ]
        }
      ]
      scale:{
        minReplicas: 0
      }
    }
  }
}

output fqdn string = resContainerApps.properties.configuration.ingress.fqdn
