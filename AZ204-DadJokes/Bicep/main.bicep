param location string = resourceGroup().location
param parPrincipalId string

// Resource group name: az204-dadjokes-rg

resource resContainerRegistry 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' = {
  name: 'acrDadjokesPc'
  location: location
  sku: {
    name: 'Basic'
  }
  properties:{
    adminUserEnabled: true
  }
}

var varRoleId = 'acdd72a7-3385-48ef-bd42-f606fba81ae7' // Reader

// Create role assignment
resource resRegistryRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().subscriptionId, resourceGroup().name, resContainerRegistry.name, varRoleId, parPrincipalId)
  scope: resContainerRegistry
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', varRoleId)
    principalId: parPrincipalId
    principalType: 'User'
  }
}
