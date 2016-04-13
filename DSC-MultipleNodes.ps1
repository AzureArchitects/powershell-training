Configuration WebServerConfig {
    
    param (
    [string]$computerName= "localhost"
    )
    
    Import-DscResource –ModuleName PSDesiredStateConfiguration
     
    Node $ComputerName
    {

            
         File InstallScriptFolder
            {
            Ensure = "present"
            DestinationPath = "c:\blobs"
            Type = "Directory"

            }

    }

}

WebServerConfig -OutputPath c:\test -ComputerName "WEB01"

 
