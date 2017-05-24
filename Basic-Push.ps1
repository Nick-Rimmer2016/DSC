configuration SFTP_Servers
{
    
    param (
            [Parameter(Mandatory=$true)]
            [ValidateNotNullOrEmpty()]
            [String[]]$ComputerName
          )
   
    Import-DscResource -ModuleName xPSDesiredStateConfiguration 
    Import-DscResource -ModuleName cNtfsAccessControl 
    Import-LocalizedData -BaseDirectory .\ -FileName sftp-config.psd1 -BindingVariable Data
    
    node $computername   

    {
        File DSCResourceFolder
        {
            SourcePath = "\\dc1\dscresource"
            DestinationPath = "C:\Program Files\WindowsPowerShell\Modules"
            Recurse = $true
            Type = "Directory"
        }

        File BinFilePresent
        {
            SourcePath = "\\dc1\dscresource\test.bin"
            DestinationPath = "c:\test\home"
            Recurse = $true
            Type = "File"
            DependsOn = '[File]CreateFileStructure' 
        }
                       
        File CreateFileStructure
        {
            Ensure          = "Present"
            DestinationPath = $data.FolderStructure
            Type            = "Directory"
            
        } 

        cNtfsPermissionEntry PermissionSet1
        {
        Ensure = 'Present'
        Path = "C:\test\home"
        Principal = $data.Username
        AccessControlInformation = @(
            cNtfsAccessControlInformation
            {
                AccessControlType = 'Allow'
                FileSystemRights = 'ReadAndExecute'
                Inheritance = 'ThisFolderSubfoldersAndFiles'
                NoPropagateInherit = $false
            }
        )
        DependsOn = '[File]CreateFileStructure','[File]DSCResourceFolder' 
         
        }
}
}

SFTP_Servers  -computername APP1,APP2
