#!/usr/local/bin/expect

#exp_internal 1 # Uncomment for debug
# argument 900 10.0.0.0 255.255.255.248 10.0.0.1 10.0.0.2-10.0.0.6
set env(TERM) dumb
set prompt "( :> %|#|\\$) $";
set timeout 10
match_max 100000
set vlan [lindex $argv 0];
set network [lindex $argv 1];
set mask [lindex $argv 2];
set address [lindex $argv 3];
set range [lindex $argv 4];
spawn telnet 10.61.0.26
expect "Password:" { send "\r"}
expect "Login:" { send "admin+ct\r"}
expect -exact "Password:" { send "Joptitel\r"}
expect ">" { send "/interface vlan\r"}
expect ">" { send "add interface=ether2 l2mtu=1576 name=vlan$vlan vlan-id=$vlan\r"}
expect ">" { send "/ip address\r"}
expect ">" { send "add address=$address/$mask interface=vlan$vlan network=$network\r"}
expect ">" { send "/ip pool\r"}
expect ">" { send "add name=pool_vlan$vlan ranges=$range\r"}
expect ">" { send "/ip dhcp-server\r"}
expect ">" { send "add address-pool=pool_vlan$vlan disabled=no interface=vlan$vlan name=dhcp_vlan$vlan\r"}
expect ">" { send "/ip dhcp-server network\r"}
expect ">" { send "add address=$network/$mask dns-server=194.190.110.245,8.8.8.8 gateway=$address\r"}
sleep 2
close
