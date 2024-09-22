$ApprovedDns = "129.151.195.126,129.151.207.4,129.151.195.112,10.10.10.105"
$ApprovedDnslist = $ApprovedDns.split(",")
$result = 0

$inet1 = Get-DnsClient  | Get-DnsClientServerAddress| Where-Object -FilterScript {$_.AddressFamily -eq "2"} 
foreach($nic in $inet1){
    $InterfaceDNS = $null
    $InterfaceDNS = Get-DnsClientServerAddress -InterfaceIndex $nic.InterfaceIndex -AddressFamily IPv4
    if ($null -eq (Compare-Object -ReferenceObject $ApprovedDnslist  -DifferenceObject ($InterfaceDns.ServerAddresses))) {
        #Write-Host -Message "Interface $($InterfaceDns.InterfaceAlias) settings are okay."
    }
    else {
        #Write-Host -Message "Interface $($InterfaceDns.InterfaceAlias) settings are not okay."
        $result++
        }
    }
    if ($result -eq 0){
        exit 0
    }else {
        exit 1
    }