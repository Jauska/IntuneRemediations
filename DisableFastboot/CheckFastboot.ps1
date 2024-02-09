$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$value = Test-Path $regPath
$regkey = (((Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberBootEnabled' -ErrorAction SilentlyContinue).HiberbootEnabled -eq 0))
if($value){
        if ($regkey) {
                exit 0
        }
 }
Else{
        exit 1
}