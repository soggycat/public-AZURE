$nsg = Get-AzNetworkSecurityGroup
$exportPath = '<C:\somewhere>'

Foreach ($nsg in $nsgs){
New-Item -ItemType file -Path "$exportPath\$($nsg.Name).csv" -Force
$nsgRules = $nsg.SecurityRules
    foreach ($nsgRule in $nsgRules){
    $nsgRule | Select-Object Name,Description,Priority,Protocol,Access,Direction,@{Name=’SourceAddressPrefix’;Expression={[string]::join(“,”, ($_.SourceAddressPrefix))}},@{Name=’SourcePortRange’;Expression={[string]::join(“,”, ($_.SourcePortRange))}},@{Name=’DestinationAddressPrefix’;Expression={[string]::join(“,”, ($_.DestinationAddressPrefix))}},@{Name=’DestinationPortRange’;Expression={[string]::join(“,”, ($_.DestinationPortRange))}} `
    | Export-Csv "$exportPath\$($nsg.Name).csv" -NoTypeInformation -Encoding ASCII -Append}
}

