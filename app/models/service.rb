# -*- encoding : utf-8 -*-
class Service < ActiveRecord::Base
  ActiveRecord::Base.send :include, ServicesHelper
  attr_accessible :addr, :city, :cl_id, :ipaddr, :port_id, :serv_id, :speed, :status, :type_s, :vlan, :pool, :notice
  after_create :create_config
#  after_update :update_config
  before_destroy :destroy_config
  after_destroy :update_dhcp_conf

  def self.search(search)
    if search
      where('services.type_s LIKE ? OR services.addr LIKE ? OR services.city LIKE ? OR services.ipaddr LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

  def result_output_fname
    '/tmp/mng_service.output'
  end
  protected
#-------------------------------------------------------------------
	def logger2(str)
		logger.debug str
		temp_output = File.new(result_output_fname, "a+")
		temp_output.write str
		temp_output.close
        self.attributes[:notice] = "#{self.attributes[:notice]}<br>\n#{str}"
	end

  def mikrotik_ip(action,s)
logger2 s.inspect
    network,mask = s.ipaddr.split(/\//)
logger2 s.ipaddr.inspect
logger2 action

    ar = IPAddr.new(s.ipaddr).to_range.to_a
    logger2 Time.now
    case action
    when 'add4'
      logger2("ssh -l admin 10.61.0.26 \\$add4 vlan=#{s.vlan} network=\"#{network}\" mask=#{mask} ip=\"#{ar[1].to_s}\" range=\"#{ar[2].to_s}-#{ar[-2].to_s}\"")
	  `ssh -l admin 10.61.0.26 :global add4 [:parse [/system script get add_ipv4 source]]`
      `ssh -l admin 10.61.0.26 \\$add4 vlan=#{s.vlan} network=\"#{network}\" mask=#{mask} ip=\"#{ar[1].to_s}\" range=\"#{ar[2].to_s}-#{ar[-2].to_s}\"`
    when 'add6'
      logger2("ssh -l admin 10.61.0.26 \\$add6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}\"")
	  `ssh -l admin 10.61.0.26 :global add6 [:parse [/system script get add_ipv6 source]]`
      `ssh -l admin 10.61.0.26 \\$add6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}"`

    when 'remove4'
      logger2("ssh -l admin 10.61.0.26 \\$myremove4 vlan=#{s.vlan} network=\"#{network}\" ip=\"#{ar[1].to_s}\"")
	  `ssh -l admin 10.61.0.26 :global myremove4 [:parse [/system script get remove_if4 source]]`
      `ssh -l admin 10.61.0.26 \\$myremove4 vlan=#{s.vlan} network=\"#{network}\" ip=\"#{ar[1].to_s}\"`
    when 'remove6'
      logger2("ssh -l admin 10.61.0.26 \\$myremove6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}\"")
	  `ssh -l admin 10.61.0.26 :global myremove6 [:parse [/system script get remove_if6 source]]`
      `ssh -l admin 10.61.0.26 \\$myremove6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}\"`
    end
  end
  
  def update_config
    case self.type_s
	when 'nat'
		mikrotik_ip('remove4',self)
		mikrotik_ip('add4',self)
    when 'inet6'
		mikrotik_ip('remove6',self)
		mikrotik_ip('add6',self)
	end
  end

  def create_config
	case type_s
	when 'nat'
#		ipv6 = get_ip6net.split('/')[0]
#		mikrotik_ip('add4',self)
#		attr = self.attributes
#		attr.delete("serv_id")
#		ipv6_s = Service.new(attr)
#		ipv6_s.ipaddr = ipv6
#		ipv6_s.type_s = 'inet6'
#		mikrotik_ip('add6',ipv6_s)
#		ipv6_s.save		  
	when 'ipunnam'
		create_cisco_interface
		update_dhcp_conf
    end
	if self.city == 'Батайск'
		logger2("ssh -l admin 10.61.0.15 \\$add_one_vpls vlan=#{self.vlan}")
		`ssh -l admin 10.61.0.15 :global addvlan [:parse [/system script get add_one_vpls source]]`
		`ssh -l admin 10.61.0.15 \\$addvlan vlan=#{self.vlan}`
		`ssh -l admin 10.61.0.101 :global addvlan [:parse [/system script get add_one_vpls source]]`
		`ssh -l admin 10.61.0.101 \\$addvlan vlan=#{self.vlan}`
	end
  end
  
  def destroy_config
	case self.type_s
	when 'nat'
		mikrotik_ip('remove4',self)
	when 'inet6'
		mikrotik_ip('remove6',self)
	when 'pool'
		mikrotik_ip('remove_pool',self)
	when 'ipunnam'
		destroy_cisco_interface if Service.where(vlan: self.vlan).where("serv_id <> ?",self.serv_id).empty?
    end
#	if self.city == 'Батайск' && Service.where(vlan: self.vlan).where("serv_id <> ?",self.serv_id).empty?
	if self.city == 'Батайск'
		logger2("ssh -l admin 10.61.0.15 \\$del_vlan vlan=#{self.vlan}")
		`ssh -l admin 10.61.0.15 :global delvlan [:parse [/system script get del_vpls_vlan source]]`
		`ssh -l admin 10.61.0.15 \\$delvlan vlan=#{self.vlan}`
		`ssh -l admin 10.61.0.101 :global delvlan [:parse [/system script get del_vpls_vlan source]]`
		`ssh -l admin 10.61.0.101 \\$delvlan vlan=#{self.vlan}`
	end
  end

  def update_dhcp_conf
    return unless self.type_s == 'inet' || self.type_s == 'ipunnam' || self.type_s == 'one-ip' 
	logger2 self.inspect
	mma = /(\d+\.\d+\.\d+)\./.match(self.ipaddr)
    net_addr = mma[1]
	@services = {}
	Service.where("type_s in ('one-ip','inet','ipunnam') AND NOT cl_id in (71,413) AND ipaddr like ?",net_addr+".%").order(:pool).each do |service|
		net = IPAddr.new service.pool.chomp
		if @services[service.pool].nil?
			@services[service.pool] = {}
			@services[service.pool][:net_addr] = net.to_s
			@services[service.pool][:net_mask] = net.inspect.split(/[\/>]/)[1]
			@services[service.pool][:gw_addr] = IPAddr.new(net.to_i+1,Socket::AF_INET).to_s
			@services[service.pool][:net_broadcast] = net.to_range.last.to_s
			@services[service.pool][:vlans] = {}
		end
#		@services[service.pool][:vlans][service.vlan] = service.type_s == 'one-ip' || service.type_s == 'ipunnam' ? service.ipaddr : IPAddr.new(net.to_i+2,Socket::AF_INET).to_s
		@services[service.pool][:vlans][service.vlan] = [] if @services[service.pool][:vlans][service.vlan].nil?
		vlan_ip =   if service.type_s == 'one-ip' || service.type_s == 'ipunnam'
						service.ipaddr
					elsif net.to_range.to_a.length > 4
						IPAddr.new(net.to_i+2,Socket::AF_INET).to_s << " " << IPAddr.new(net.to_range.to_a[-2],Socket::AF_INET).to_s
					else
						IPAddr.new(net.to_i+2,Socket::AF_INET).to_s
					end
		@services[service.pool][:vlans][service.vlan].push vlan_ip

		end
	template = File.read("#{Rails.root}/app/views/dhcp/dhcp.conf.erb")
	renderer = ERB.new(template)
	result = renderer.result(binding)
	IO.popen("ssh dhcpd@194.190.110.241 \"cat > ~/#{net_addr}.0.dhcpd.conf\"","w") {|f| f.write(result) }
	IO.popen("ssh dhcpd@194.190.110.241 \"sudo /usr/local/etc/rc.d/isc-dhcpd restart >/dev/null 2>&1\"","w") {|f| f.write(result) }
	IO.popen("ssh dhcpd@194.190.110.242 \"cat > ~/#{net_addr}.0.dhcpd.conf\"","w") {|f| f.write(result) }
	IO.popen("ssh dhcpd@194.190.110.242 \"sudo /usr/local/etc/rc.d/isc-dhcpd restart >/dev/null 2>&1\"","w") {|f| f.write(result) }
end

  def create_cisco_interface
#    f = IO.popen("curl http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/#{self.id}.tcl")
#    f.each {|str| logger2 str }
#    f.close
    f = IO.popen("rsh -l maxim 10.61.0.51 tclsh http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/#{self.id}.tcl")
    f.each {|str| logger2 str }
    f.close
	f = IO.popen("rsh -l maxim 10.61.0.61 tclsh http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/#{self.id}.tcl")
    f.each {|str| logger2 str }
    f.close
	f = IO.popen("rsh -l maxim 10.61.0.100 tclsh http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/#{self.id}.tcl")
    f.each {|str| logger2 str }
    f.close
  end

  def destroy_cisco_interface
#    f = IO.popen("curl http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/destroy/#{self.id}.tcl")
#    f.each {|str| logger2 str }
#    f.close
    f = IO.popen("rsh -l maxim 10.61.0.51 tclsh http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/destroy/#{self.id}.tcl")
    f.each {|str| logger2 str }
    f.close
	f = IO.popen("rsh -l maxim 10.61.0.61 tclsh http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/destroy/#{self.id}.tcl")
    f.each {|str| logger2 str }
    f.close
	f = IO.popen("rsh -l maxim 10.61.0.100 tclsh http://m.klimenko:08Ifiksr10@#{ENV['URL']}/services/destroy/#{self.id}.tcl")
    f.each {|str| logger2 str }
    f.close
  end

end
