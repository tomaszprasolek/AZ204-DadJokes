param parLocation string = resourceGroup().location
param parName string

resource resLaw 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: parName
  location: parLocation
  properties:{
    retentionInDays: 30
    sku:{
      name: 'PerGB2018'
    }
  }
}
