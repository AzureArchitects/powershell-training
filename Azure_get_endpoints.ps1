
#deze nog verbeteren (IP adres moet ook in output)

$VMlist = Get-AzureVM

foreach ($VMServiceName in $VMlist) {

    $vm = Get-AzureVM -ServiceName $VMServiceName.ServiceName -Name $VMServiceName.Name | Get-AzureEndpoint 

    $Output = New-Object PSObject 
    $Output | Add-Member VMName $VMServiceName.Name    
    $Output | Add-Member EndpointNames $vm.Name   
    $Output | Add-Member Endpoints $vm.LocalPort

    Write-Output $Output 
}
