$RegPath = "HKLM:\Software\Policies\Microsoft\PowerShellCore"
$RegValueName = "UseWindowsPowerShellPolicySetting"
if ((Get-ItemProperty -Path $RegPath -ErrorAction SilentlyContinue).$RegValueName -eq 1) {
    exit 0
}else{
    exit 1
}