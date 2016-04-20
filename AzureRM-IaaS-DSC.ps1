Configuration WebServerConfig 
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

    Node Localhost
    {
         File CreateScriptsFolder
            {
                Ensure = 'Present'
                Type= 'Directory'
                DestinationPath = 'c:\Scripts'
            }


         WindowsFeature InstallIIS
            {        
                Name = 'Web-Server'
                Ensure = 'Present' 

            }
    }
}