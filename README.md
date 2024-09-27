# vsphere-copy-portgroups-powercli
### What it does:
Copies vsphere virtual swithes port groups for specific virtual switch from one vsphere host to another
it checks if the portgroup is not configured as VMkernel Network Adapter and if vlan id is existing
also it checks if the copied port group already exists on destination host and if it does it won`t copy it there.
### How to run:
Install Powercli from https://developer.broadcom.com/powercli <br>
Run powershell script with CMD or Powershell using params listed below


### [+]Syntax: 
.\copy_portgroups.ps1 -HostFrom NameVMHost1 -HostTo NameVMHost2  -Server Server -User username -Passwd password -Vswitch Vswitch[num]
### [+]Parameters:
  + -HostFrom         : First name or ip VMHost (for example: server1.domain.com)
  + -HostTo           : Second name or ip VMHost (for example: server2.domain.com)
  + -Server           : Vsphere server that you want to connect
  + -User             : the username to login into the vsphere to control over host
  + -Passwd           : the password to login into the vsphere to control over host
  + -Vswitch          : vSwitch which configuration you want to copy on another host
### [+]Example usage:   
.\copy_portgroups.ps1 -hostfrom server1.domain.com -hostto server2.domain.com -Server name.subdomain.domain -User user@vsphere.local -Passwd strongPass123 -Vswitch Vswitch0
