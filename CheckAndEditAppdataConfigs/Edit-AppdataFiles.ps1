$ParentPath = $env:LOCALAPPDATA
$Foldername = "testiappi"
$configfiletoedit = "settings_.dat"
$KillProcess = "notepad.exe"
$FullSearchPath = Join-Path -Path $ParentPath -ChildPath $Foldername
$FullSearchPathExists = Test-Path -Path $FullSearchPath

$replacementMappings = @{
    "server1.jotain.com" = "serverUUSI1.jotain.com"
    "server2.jotain.com" = "serverUUSI2.jotain.com"
    "server3.jotain.com" = "serverUUSI3.jotain.com"
    "server4.jotain.com" = "serverUUSI4.jotain.com"
}

if ($FullSearchPathExists -ne $true) {
    exit 1
}
If (((Get-Process).ProcessName -contains $KillProcess)) {
    Stop-Process -Name $KillProcess -Force -Confirm:$false
}
$FilesToBeEdited = Get-ChildItem -Path $FullSearchPath -Recurse -Filter $configfiletoedit
ForEach ($FileToEdit in $FilesToBeEdited) {
    $FileContent = Get-Content -Path $FileToEdit.FullName
    $FileBackup = $FileToEdit.FullName+".old"
    Move-Item -Path $FileToEdit.FullName -Destination $FileBackup
    foreach ($oldAddress in $replacementMappings.Keys) {
        $newAddress = $replacementMappings[$oldAddress]
        $fileContent = $fileContent.Replace("ServerAddress=$oldAddress", "ServerAddress=$newAddress")
    }
    Out-File -FilePath $FileToEdit.FullName -Encoding utf8 -InputObject $FileContent
}