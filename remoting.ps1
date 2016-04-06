
Function Get-Info {

  [string]$hostname = hostname
  $adpcArray = @()
  $adpc = Get-ADComputer -Filter * | Select Name
  $adpc | foreach-object { $adpcArray += $_.Name }
  $adpcList = {$adpcArray}.Invoke()
  $adpcList.Remove($hostname.ToUpper()) | Out-Null

  $computers = $adpcList


  # Instantiate the array for the objects
  $output = @();

  # Loop through all $computers in $hostname file
  foreach($entry in $computers) {
    

    # Let's create a complex object with an array as a property
    $psversions = invoke-command $entry {$PSVersionTable} 
    $psversion = @()
    foreach ($p in $psversions) {
        
        $psobject = [pscustomobject]@{
            PSVersie = $p.PSVersion
            WSMANVersie = $p.WSManStackVersion
        }
        
        $psversion += $psobject
        
    } 
   
    
    # Collect other info
    $info = Get-CimInstance -Classname Win32_OperatingSystem -Computername $entry
    $bios = Get-CimInstance -Classname Win32_Bios -Computername $entry
	   
       
    # create the object for reporting
    $object = [pscustomobject]@{
                      hostname = $info.PSComputerName;
                      os = $info.caption;
                      fabrikant = $bios.manufacturer;
                      serial = $info.serialnumber;
                      registratienaam = $info.registereduser;
                      datum = (Get-Date);
                      company = 'Contoso';
                      powershell = $psversion;
    
        }
    $output += $object
    }
    Write-Output $output
 }

