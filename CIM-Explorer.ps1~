Function Get-MDSCimClassProperties {

    param (

        [string]$classname,
        [string]$outfile


    )

    #Get all CIM classes
    $cim = Get-CimClass
    
    #Filter CimClass
    $methods = $cim.where{ $_.CimclassName -like "*$classname*"}

    #Get properties per class and group them per class
    $groups = $methods | Select-Object CimclassName -ExpandProperty CimclassProperties | Group-Object CimclassName
    
   
    $style = '<style> table,th,td { border-width: 1px; border-style: solid; border-color: grey; } </style>'

    $body = ''

    ForEach ($item in $groups) 
    {
        $body+= "<h1>$($item.name)</h1>"
        $body+=$item.Group | Select-Object CimclassName,Name | ConvertTo-HTML –Fragment –As Table
    }
    ConvertTo-HTML –Head $style –Body $body | Out-File $outfile 


}


Get-MDSCimClassProperties -classname '' -outfile 'dump3.html' 