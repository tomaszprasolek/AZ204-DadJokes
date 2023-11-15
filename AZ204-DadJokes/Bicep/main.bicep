param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' = {
  name: 'acrDadjokesPc'
  location: location
  sku: {
    name: 'Basic'
  }
  properties:{
    adminUserEnabled: true
  }
}
