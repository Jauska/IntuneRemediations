$RegPath = "HKLM:\Software\Policies\Microsoft\PowerShellCore"
$RegValueName = "UseWindowsPowerShellPolicySetting"
$regPathExists = Test-Path -Path $RegPath

if ($regPathExists){
    New-ItemProperty -Path $RegPath -Name $RegValueName -Value 1  -ErrorAction SilentlyContinue -Force # 1 -eq enabled 
}elseif ($regPathExists -eq $false) {
    New-Item -Path $RegPath -ErrorAction SilentlyContinue -Force
    New-ItemProperty -Path $RegPath -Name $RegValueName -Value 1  -ErrorAction SilentlyContinue -Force
}