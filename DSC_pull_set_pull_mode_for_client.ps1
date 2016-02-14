Configuration SetPullMode
{
param([string]$guid)
Node client01
{
LocalConfigurationManager
{
ConfigurationMode = ‘ApplyOnly’
ConfigurationID = $guid
RefreshMode = ‘Pull’
DownloadManagerName = ‘WebDownloadManager’
DownloadManagerCustomData = @{
ServerUrl = ‘http://pull01:8080/PSDSCPullServer.svc’;
         AllowUnsecureConnection = ‘true’ }
}
}
}
SetPullMode –guid $Guid 
Set-DSCLocalConfigurationManager –Computer client01 -Path ./SetPullMode –Verbose

#$cimSession = New-CimSession -SessionOption $cimSessionOption -ComputerName WinVMs.CloudApp.net -Port 50798 -Authentication Negotiate -Credential (Get-Credential)