param parLocation string = resourceGroup().location
param parName string
param parLogAnalyticsWorkspaceName string

resource resLogAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: parLogAnalyticsWorkspaceName
}

var varPrimaryKey = resLogAnalyticsWorkspace.listKeys().primarySharedKey

resource resEnvironment 'Microsoft.App/managedEnvironments@2023-05-02-preview' = {
  name: parName
  location: parLocation
  properties:{
    appLogsConfiguration:{
      destination: 'log-analytics'
      logAnalyticsConfiguration:{
        customerId: resLogAnalyticsWorkspace.properties.customerId
        sharedKey: varPrimaryKey
      }
    }
  }
}

output id string = resEnvironment.id
