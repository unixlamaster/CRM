#!/usr/bin/perl

use Switch;

use Net::Telnet;
use Expect;

#use Data::Dumper;

$gw_ip="10.61.0.26";
$user="admin+ct";
$passwd="Joptitel";

$interface = "ether2";

my $action = shift;

my $conn = Net::Telnet->new( -host => $gw_ip , -timeout => 60, -errmode => +"return");
$conn->login( $user,$passwd );

do { print qq{Login Failed for '$host'} ;
exit 1 } if ( $conn->errmsg );

switch ($action){
	case "add" { add_to($conn, $interface, @ARGV); }
	case "remove" { remove_from($conn, @ARGV); }
	else { print "Make a choice\n"; }
}

sub add_to{
	my $t = shift;
	my $if = shift;
	my ($vlan, $network, $mask, $ip, $range, $ipv6 ) = @ARGV;
	my @out1 = $t->cmd("/interface vlan add interface=$if l2mtu=1576 name=vlan$vlan vlan-id=$vlan");
	@out1 = $t->cmd("/ip address add address=$ip/$mask interface=vlan$vlan network=$network");
	@out1 = $t->cmd("/ip pool add name=pool_vlan$vlan ranges=$range");
	@out1 = $t->cmd("/ip dhcp-server add address-pool=pool_vlan$vlan disabled=no interface=vlan$vlan name=dhcp_vlan$vlan");
	@out1 = $t->cmd("/ip dhcp-server network add address=$network/$mask dns-server=194.190.110.245,8.8.8.8 gateway=$ip");
	@out1 = $t->cmd("/ipv6 pool add name=poolv6_vlan$vlan prefix=$ipv6/64 prefix-length=64");
	@out1 = $t->cmd("/ipv6 dhcp-server add address-pool=poolv6_vlan$vlan disabled=no interface=vlan$vlan name=dhcpv6_vlan$vlan");
	@out1 = $t->cmd("/ipv6 address add address=$ipv6 interface=vlan$vlan");
}

sub remove_from{
	my $t = shift;
	my ($vlan, $network, $mask, $ip, $ip_range, $ipv6 ) = @ARGV;
#	my @out1 = $t->cmd("/ip dhcp-server network print");
	my @out1 = `ssh -l admin 10.61.0.26 /ip dhcp-server network print`;
	my $num = rem_network($network,@out1);
	$t->cmd("/ip dhcp-server network remove numbers=$num");
	$t->cmd("/ip dhcp-server remove dhcp_vlan$vlan");
	$t->cmd("/ip pool remove pool_vlan$vlan");
	@out1 = `ssh -l admin 10.61.0.26 /ip address print`;
#	@out1 = $t->cmd("/ip address print");
	$num = rem_network($ip,@out1);
	$t->cmd("/ip address remove numbers=$num");
#	@out1 = $t->cmd("/ipv6 address print");
	@out1 = `ssh -l admin 10.61.0.26 /ipv6 address print`;
	$num = ipv6_network($ipv6,@out1);
	$t->cmd("/ipv6 address remove numbers=$num");
        @out1 = `ssh -l admin 10.61.0.26 /ipv6 dhcp-server print`;
#	@out1 = $t->cmd("/ipv6 dhcp-server print");
	$num = ipv6_dhcp($vlan,@out1);
	$t->cmd("/ipv6 dhcp-server remove numbers=$num");
	$t->cmd("/ipv6 pool remove poolv6_vlan$vlan");
	$t->cmd("/interface vlan remove vlan$vlan");
}

sub ipv6_dhcp{
	my $vl = shift;
	my @str_list = @_;
	my $choice = "dhcpv6_vlan$vl";
	foreach my $line (@str_list){
		$line =~ s/^\s+//;
		my @word = (split /\s+/, $line);
		if (@word[1] eq $choice){
			return @word[0];
		}
	}
	return -1;
}

sub ipv6_network{
	my $net_address = shift;
	my @str_list = @_;
	foreach my $line (@str_list){
		$line =~ s/^\s+//;
		my @word = (split /\s+/, $line);
		#print @word[1]."\n";
		if (@word[0] =~ /^\d+$/){
			my ($net,$msk) = (split /\//, @word[2] );
			if ($net_address eq $net){
				return @word[0];
			}
		}
	}
	return -1;
}

sub rem_network{
	my $net_address = shift;
	my @str_list = @_;
	foreach my $line (@str_list){
		$line =~ s/^\s+//;
		my @word = (split /\s+/, $line);
		#print @word[1]."\n";
		if (@word[0] =~ /^\d+$/){
			my ($net,$msk) = (split /\//, @word[1] );
			if ($net_address eq $net){
				return @word[0];
			}
		}
	}
	return -1;
}
