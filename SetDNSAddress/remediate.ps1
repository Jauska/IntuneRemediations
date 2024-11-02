$inet1 = Get-DnsClient  | Get-DnsClientServerAddress| Where-Object -FilterScript {$_.AddressFamily -eq "2"} 
foreach($nic in $inet1){
    Set-DnsClientServerAddress -InterfaceIndex $nic.InterfaceIndex -ServerAddresses ("79.76.49.92","129.151.198.93","129.151.195.112","10.10.10.105")
}