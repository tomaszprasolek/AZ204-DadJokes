@allowed([
  'dev'
  'test'
])
param environmentType string
@sys.description('Format: v0.0.0')
param version string
param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' existing = {
  name: 'acrDadjokesPc'
}

resource aci 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: '${environmentType}dadjokes'
  location: location
  properties: {
    imageRegistryCredentials:[
      {
        server: acr.properties.loginServer
        username: acr.listCredentials().username
        password: acr.listCredentials().passwords[0].value
      }
    ]
    containers: [
      {
        name: '${environmentType}dadjokes'
        properties: {
          image: 'acrdadjokespc.azurecr.io/dadjokes:${version}'
          ports:[
            {
              port: 80
            }
          ]
          resources: {
            requests: {
              cpu: 1 // TODO: check default value
              memoryInGB: 2 // TODO: check default value
            }
          }
          environmentVariables:[
            {
              name: 'RunningEnvironment'
              value: 'azure-${environmentType}'
            }
            {
              name: 'VERSION'
              value: version
            }
          ]
        }
      }   
    ]
    osType: 'Linux'
    restartPolicy: 'OnFailure'
    ipAddress:{
      ports:[
        {
          port: 80
        }
      ]
      type: 'Public'
      dnsNameLabel: 'tomo${environmentType}dadjokes'
    }
  }
}
