$ParentPath = $env:LOCALAPPDATA
$foldername = "testiappi"
$configfiletoedit = "settings_.dat"
$FullSearchPath = $ParentPath+"\"+$foldername
$FullSearchPathExists = Test-Path -Path $FullSearchPath
if ($FullSearchPathExists -ne $true) {
    exit 0
}
$FilesToBeEdited = Get-ChildItem -Path $FullSearchPath -Recurse -Filter $configfiletoedit
ForEach ($FileToEdit in $FilesToBeEdited) {
    $FileContent = Get-Content -Path $FileToEdit.FullName
    if (($FileContent -contains "ServerAddress=server1.jotain.com") -or ($FileContent -contains "ServerAddress=server2.jotain.com") -or ($FileContent -contains "ServerAddress=server3.jotain.com") -or ($FileContent -contains "ServerAddress=server3.jotain.com")) {
        exit 1
    }else {
        exit 0
    }
}