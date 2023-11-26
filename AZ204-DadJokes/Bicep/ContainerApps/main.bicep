param parLocation string = resourceGroup().location
@sys.description('Format: v0.0.0')
param parVersion string

var varLogAnalyticsWorkspaceName = 'logAnalyticsWorkspace-production'

module modLogAnalyticsWorkspace 'logAnalyticsWorkspace.bicep' = {
  name: 'log-analytics-workspace'
  params: {
    parName: varLogAnalyticsWorkspaceName
    parLocation: parLocation
  }
}

module containerAppEnvironment 'environment.bicep' = {
  name: 'container-app-environment'
  params: {
    parLogAnalyticsWorkspaceName: varLogAnalyticsWorkspaceName
    parName: 'cae-dadjokes-ne'
    parLocation: parLocation
  }
}

module containerApp 'containerApps.bicep' = {
  name: 'container-app'
  params: {
    parLocation: parLocation
    parEnvironmentId: containerAppEnvironment.outputs.id
    parVersion: parVersion
  }
}

output fqdn string = containerApp.outputs.fqdn
