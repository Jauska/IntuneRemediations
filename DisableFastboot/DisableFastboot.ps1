$Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$value = "HiberBootEnabled"

If(Test-Path -Path "Registry::$Key") {
    Set-ItemProperty -Path "Registry::$key" -Name $value -Value "0"
    if(((Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberBootEnabled' -ErrorAction SilentlyContinue).HiberbootEnabled -eq 0)){
        Return 0
    }
}
Else {
    Return 1
}