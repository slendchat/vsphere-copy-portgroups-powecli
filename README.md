# vsphere-copy-portgroups-powecli

### [+]Syntax: 
.\copy_portgroups.ps1 -HostFrom <NameVMHost1> -HostTo <NameVMHost2>  -Server <Server> -User <username> -Passwd <password> -Vswitch <Vswitch[num]>
### [+]Parameters:
  + -HostFrom         : First name or ip VMHost (for example: server1.domain.com)
  + -HostTo           : Second name or ip VMHost (for example: server2.domain.com)
  + -Server           : Vsphere server that you want to connect
  + -User             : the username to login into the vsphere to control over host
  + -Passwd           : the password to login into the vsphere to control over host
  + -Vswitch          : vSwitch which configuration you want to copy on another host
### [+]Example usage:   
<br>.\copy_portgroups.ps1 -hostfrom server1.domain.com -hostto server2.domain.com -Server name.subdomain.domain -User user@vsphere.local -Passwd strongPass123 -Vswitch Vswitch0
