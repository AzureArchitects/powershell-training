Configuration MyFirstConfig {
 
Node Tinkerpad {
    
    File SyncDir {
        DestinationPath = "c:\temp\replica"
        Type = "Directory" 
        Ensure = "Present"   
    }
  }
}
 
MyFirstConfig -OutputPath c:\DSC