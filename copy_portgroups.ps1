param (
    [string]$HostFrom,
    [string]$HostTo,
    [string]$Server,
    [string]$User,
    [string]$Passwd,
    [string]$Virtswitch
)

if (-not $HostFrom -or -not $HostTo -or -not $Server -or -not $User -or -not $Passwd -or -not $Virtswitch) {
    Write-Host "[+]Syntax: .\copy_portgroups.ps1 -HostFrom <NameVMHost1> -HostTo <NameVMHost2>  -Server <Server> -User <username> -Passwd <password> -Virtswitch <vSwitch[num]>"
    Write-Host ""
    Write-Host "[+]Parameters:"
    Write-Host "  -HostFrom         : First name or ip VMHost (for example: server1.domain.com)"
    Write-Host "  -HostTo           : Second name or ip VMHost (for example: server2.domain.com)"
    Write-Host "  -Server           : Vsphere server that you want to connect"
    Write-Host "  -User             : the username to login into the vsphere to control over host"
    Write-Host "  -Passwd           : the password to login into the vsphere to control over host"
    Write-Host "  -Virtswitch          : vSwitch which configuration you want to copy on another host"
    Write-Host "[+]Example usage:   .\copy_portgroups.ps1 -hostfrom server1.domain.com -hostto server2.domain.com -Server name.subdomain.domain -User user@vsphere.local -Passwd strongPass123 -Virtswitch Vswitch0"
    exit
}

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore

Connect-VIServer -Server $Server -Protocol https -User $User -Password $Passwd

$vswitch = Get-VirtualSwitch -VMHost $HostTo -Name $Virtswitch


$vmfrom = Get-VMHost -Name $HostFrom
$vmto = Get-VMHost -Name $HostTo
	
$vm_from_settings = Get-VirtualPortgroup -VMHost $vmfrom | Select-Object Name, VlanId, Port
$vm_to_settings = Get-VirtualPortgroup -VMHost $vmto | Select-Object Name, VlanId, Port

$filtered_vm_from_settings = $vm_from_settings | Where-Object { $_.Port -notlike '*host*' -and $_.VlanId -ne 0 }
$filtered_vm_to_settings = $vm_to_settings | Where-Object { $_.Port -notlike '*host*' -and $_.VlanId -ne 0 }



$filtered_vm_from_settings
$filtered_vm_to_settings

$vswitch_ports_group_to_add = @()

foreach ($portGroup in $filtered_vm_from_settings) {
    if (-not ($filtered_vm_to_settings | Where-Object { $_.Name -eq $portGroup.Name })) {
        $vswitch_ports_group_to_add += [PSCustomObject]@{
            Name   = $portGroup.Name
            VlanId = $portGroup.VlanId
        }
    }
}

foreach ($portGroup in $vswitch_ports_group_to_add) {
   New-VirtualPortGroup -VirtualSwitch $vswitch -Name $portGroup.Name -VLanId $portGroup.VlanId
}


Write-Host -NoNewLine 'Press any key to exit...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
