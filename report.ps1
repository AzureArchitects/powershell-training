$users = Get-ADUser -Filter * -SearchBase 'OU=NL,DC=MDS,DC=LOCAL' -Properties DisplayName,Department,Company,GivenName | Select-Object DisplayName,Department,Company,GivenName | Group-Object -Property Department
#$depts = $users | Group-Object -Property Department

$body = @"
  <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Onze medewerkers</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
     <div class="container">

      <div class="starter-template">
"@


foreach ($item in $users) {
  $body+="<h2>$($item.name) - $($item.count)</h2>"
  $body+= $item.Group | 
  Select-Object DisplayName,Department,Company,@{Name='Roepnaam';Expression={$_.GivenName}} | Convertto-Html -Fragment -As Table
}

$post = @"
<h6>$(Get-Date)</h6>
   </div>
   </div><!-- /.container -->
"@


#ConvertTo-HTML -Body $body -CssUri C:\scripts\blue.css -Title "File Report" -PostContent "<h6>$(Get-Date)</h6>"|
ConvertTo-HTML -CssUri .\bootstrap.css -Body $body  -Title 'Onze medewerkers' -PostContent $post | Out-File DumpMedewerkers.html -Encoding ascii