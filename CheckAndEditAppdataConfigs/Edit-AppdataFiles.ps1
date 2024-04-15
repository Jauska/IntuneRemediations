# Define the parent path as the local app data environment variable
$ParentPath = $env:LOCALAPPDATA
# Define the folder name
$Foldername = "testiappi"
# Define the configuration file to edit
$configfiletoedit = "settings_.dat"
# Define the process to kill
$KillProcess = "notepad.exe"
# Join the parent path and folder name to create the full search path
$FullSearchPath = Join-Path -Path $ParentPath -ChildPath $Foldername
# Check if the full search path exists
$FullSearchPathExists = Test-Path -Path $FullSearchPath
# Define the replacement mappings for the server addresses
$replacementMappings = @{
    "server1.jotain.com" = "serverUUSI1.jotain.com"
    "server2.jotain.com" = "serverUUSI2.jotain.com"
    "server3.jotain.com" = "serverUUSI3.jotain.com"
    "server4.jotain.com" = "serverUUSI4.jotain.com"
}
# If the full search path does not exist, exit the script
if ($FullSearchPathExists -ne $true) {
    exit 1
}
# If the process to kill is running, stop it
If (((Get-Process).ProcessName -contains $KillProcess)) {
    Stop-Process -Name $KillProcess -Force -Confirm:$false
}
# Get the files to be edited in the full search path
$FilesToBeEdited = Get-ChildItem -Path $FullSearchPath -Recurse -Filter $configfiletoedit

# For each file to be edited
ForEach ($FileToEdit in $FilesToBeEdited) {
    # Get the content of the file
    $FileContent = Get-Content -Path $FileToEdit.FullName
    # Backup the original file
    $FileBackup = $FileToEdit.FullName+".old"
    Move-Item -Path $FileToEdit.FullName -Destination $FileBackup
    # For each old address in the replacement mappings
    foreach ($oldAddress in $replacementMappings.Keys) {
        # Get the new address
        $newAddress = $replacementMappings[$oldAddress]
        # Replace the old address with the new address in the file content
        $fileContent = $fileContent.Replace("ServerAddress=$oldAddress", "ServerAddress=$newAddress")
    }

    # Write the updated content back to the file
    Out-File -FilePath $FileToEdit.FullName -Encoding utf8 -InputObject $FileContent
}