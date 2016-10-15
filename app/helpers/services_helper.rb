# -*- encoding : utf-8 -*-
module ServicesHelper
  def srv_type_hash
    Hash['nat','NAT, серые IP',
         'inet','Интернет',
         'one-ip','IP из пула',
         'vlan','VLAN',
         'inet6','IPv6',
         'pool','Net-Pool',
         'vols','ВОЛС',
         'voip','VoIP',
         'phone','Телефон',
         'lm-wifi','LM-WiFi',
		 'ipunnam','IP-Unnambered',
		 'routable','Маршрутизация']
  end

  def srv_city_hash
    Hash['Ростов-на-Дону','Ростов-на-Дону',
         'Батайск','Батайск',
         'Азов','Азов',
         'Аксай','Аксай',
         'хут.Ленина','хут.Ленина']
  end

  def equipment_ports_array(type_s="inet")
    ports = case type_s
              when /phone/
                Port.joins("LEFT JOIN device on ports.iddev=device.id").where("device.type='vgw'").select("device.nic as nic,ports.port as port,ports.label as label,ports.idport as idport")
              else
                Port.joins("LEFT JOIN device on ports.iddev=device.id").select("device.nic as nic,ports.port as port,ports.label as label,ports.idport as idport").order(:nic,:port)
#                Port.order(:nic,:port)
            end    
    ar = ports.all.collect {|row| ["#{row.nic}, p-#{row.port} (#{row.label})",row.idport] }
    ar.unshift([nil,nil])
  end

  def get_ipnet_voip(mask)
    get_net( %w[172.16.0.], Service.where("type_s='voip'").select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }, mask)
  end

  def get_ip4net(mask)
#    get_net( %w[62.76.94.], Service.where("type_s='inet' OR type_s='one-ip' OR type_s='pool' OR type_s='routable' OR type_s='ipunnam'").select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }, mask)
    get_net( %w[195.208.36. 194.226.109. 194.226.129. 62.76.94. 212.192.202. 92.241.15. 92.241.17.], Service.where("type_s='inet' OR type_s='one-ip' OR type_s='pool' OR type_s='routable' OR type_s='ipunnam'").select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }, mask)
	end

  def get_nat_pool(mask)
    pools_templ = []
    0.upto(255) {|i| pools_templ.push("10.1.#{i}.") }
    get_net( pools_templ, Service.where("type_s='nat'").select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }, mask)
  end

  def get_net(pools_templ,exists_ip,mask)
    new_ip = nil
    ip_prefix = nil
    found_flag = true
    pools_templ.each do |ip_pat|
      0.step(255,2**(32-mask)) do |net_pat|
         new_ip = IPAddr.new(ip_pat+net_pat.to_s+"/"+mask.to_s)
         ip_prefix = ip_pat+net_pat.to_s+"/"+mask.to_s
         found_flag = false
         exists_ip.each {|ip| break if found_flag = (ip.include?(new_ip) || new_ip.include?(ip)) }
         break unless found_flag
      end
      break unless found_flag
    end
    found_flag ? nil : ip_prefix
  end

  def get_all_ip4net(mask)
    list_ip = %w[195.208.36. 194.226.109. 194.226.129. 62.76.94. 212.192.202. 92.241.15. 92.241.17. 194.190.110.]
    exists_ip = Service.where("type_s='inet' OR type_s='one-ip' OR type_s='pool' OR type_s='routable' OR type_s='ipunnam'").select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }
    new_ip = nil
    ip_prefix = nil
    found_flag = true
    free = []
    list_ip.each do |ip_pat|
      0.step(255,2**(32-mask)) do |net_pat|
        new_ip = IPAddr.new(ip_pat+net_pat.to_s+"/"+mask.to_s)
        ip_prefix = ip_pat+net_pat.to_s+"/"+mask.to_s
        found_flag = false
        exists_ip.each {|ip| break if found_flag = (ip.include?(new_ip) || new_ip.include?(ip)) }
        free.push(ip_prefix) unless found_flag
      end
    end
    free
  end

  def get_ip6net
    list_ip = %w[2001:67C:2B88::/48]
    exists_ip = Service.where(type_s: 'inet6').select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }
    new_ip = nil
    ip_prefix = nil
    found_flag = true
    list_ip.each do |ip_pat|
      IPAddr.new(ip_pat).to_i.step(IPAddr.new(ip_pat).to_range.last.to_i,(1<<64)) do |next_ip|
         new_ip = IPAddr.new(next_ip,Socket::AF_INET6).mask(64)
         return(new_ip.to_s<<"/64") unless exists_ip.include?(new_ip)
      end
    end
    nil
  end

  def get_one_ip(from_pool)
    pool_list = Service.where(type_s: 'ipunnam', cl_id: from_pool).select("vlan,ipaddr")
    exists_ip = Service.where("type_s='inet' AND ipaddr LIKE '%/32%' OR type_s='one-ip'").select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }
    new_ip = nil
    ip_prefix = nil
    found_flag = true
    pool_list.each do |pool|
      net = pool.ipaddr
      mma = /(\d+\.\d+\.\d+\.)(\d+)\/(\d+)/.match(pool.ipaddr)
      (ip_pat, fip, mask_len) = [mma[1],mma[2].to_i+2,mma[3].to_i]
      fip.step(fip+(2**(32-mask_len))-4,1) do |net_pat|
         new_ip = IPAddr.new(ip_pat+net_pat.to_s)
logger.debug "pool=#{pool} #{new_ip} #{net}"
         return([new_ip,get_free_vlan(""),net]) unless exists_ip.include?(new_ip)
      end
    end
    [nil,nil,nil]
  end

  def get_ipunnambered(from_pools)
#      from_pools = ["62.76.94."]
	if from_pools.empty? 
		from_pools = Service.where("pool like '%/24'").select("pool,count(pool) as cc").group(:pool).order(:cc).map {|p| /(\d+\.\d+\.\d+\.)(\d+)\/(\d+)/.match(p.pool)[1] } 
	end
    exists_ip = Service.where("type_s in ('inet', 'one-ip', 'ipunnam', 'routable')").where("ipaddr LIKE '"+from_pools.join("%' OR ipaddr LIKE '")+"%'").select("ipaddr").collect {|s| IPAddr.new(s.ipaddr.gsub(/\s/,'')) }
    new_ip = nil
    ip_prefix = nil
    found_flag = true
	vlan = get_free_vlan('ipunnam')
    from_pools.each do |pool|
		post_fix = pool=='185.102.138.' ? "0/25" : "0/24"
		2.upto(254) do |net_pat|
			new_ip = IPAddr.new(pool+net_pat.to_s)
			found_flag = false
			exists_ip.each {|ip| break if found_flag = (ip.include?(new_ip) || new_ip.include?(ip)) }
			return([pool+net_pat.to_s,vlan,pool+post_fix]) unless found_flag
		end
    end
    nil
  end



  def get_free_vlan(type_s)
    exists_vlan = case (type_s)
                    when 'nat'
                      Service.where("vlan>300 AND vlan<1200")
                    else
                      Service.where("vlan>101 AND vlan<900 OR vlan>999")
                    end
    exists_vlan = exists_vlan.select("vlan").group("vlan").order("vlan").collect {|s| s.vlan}
#    logger.debug exists_vlan.inspect
    vlan=0 
    if type_s == 'nat'
      if exists_vlan.empty?
        vlan = 900
      else
        900.upto(exists_vlan[-1]+1) do |v|
          vlan=v
          break unless exists_vlan.include?(vlan)
        end
      end
    else
      102.upto(exists_vlan[-1]+1) do |v|
         vlan=v
         break unless exists_vlan.include?(vlan)
      end
    end
    vlan
  end

#-------------------------------------------------------------------

  def get_free_phone
    TypePhoneNumber.joins("LEFT JOIN services ON type_phone_numbers.phone=services.ipaddr").where("serv_id is NULL AND type_p='обычный'").select("phone").first.phone
  end
  def get_free_phones
    TypePhoneNumber.joins("LEFT JOIN services ON type_phone_numbers.phone=services.ipaddr").where("serv_id is NULL").select("phone,type_p").order("type_p,phone")
  end

  def datalist_free_phones
    res= "<datalist id=free_phones>\n"
    get_free_phones.each { |row|  res << "<option value='" << row.phone << " - " << row.type_p << "'>\n" }
    res << "</datalist>\n"
  end

#-------------------------------------------------------------------
	def get_snmp_speed(addr,port)
		begin
			manager = SNMP::Manager.new(:Host => addr, :Community =>'DiDi-RO', :Version => :SNMPv1)
			sp = manager.get_value("1.3.6.1.4.1.8886.6.1.2.2.1.3.#{port}")
			sp=~/^\d*$/ ? sp : 0
		rescue 
			0
		end
	end
#------------------------------------------------------------

  def device_port_show_speed(service)
#	if service.cl_port =~ /^sw/
#		ps = get_snmp_speed(service.device_ip,service.device_port)
#		if service.speed.to_i != ps.to_i
#			"#{service.speed} <font size=1>(#{ps})</font>".html_safe
#		else
#			service.speed
#		end
#	else
#		service.speed
#	end
	service.speed
  end
  
#------------------------------------------------------------
	def show_router_helper(service)
		gw={'195.208.36.190'=>'<a href=telnet://10.61.0.1>Red</a> -> ', '194.190.110.94'=>'<a href=http://10.61.0.26>White</a> ->'}
		case service.type_s
		when /nat|inet6/
			'<a href=http://10.61.0.26/>White</a> ->'.html_safe
#	when /^inet$|one-ip/
#			gw[`ssh -l admin 10.61.0.235 /ip route check dst-ip=212.192.202.196 once|grep nexthop|awk '{print $2}'`.chomp].html_safe
		else
			""
		end
	end
#------------------------------------------------------------
	def get_interface_ipunnam(pool)
		hh = {'185.102.138.0/25' => 'GigabitEthernet0/2.221',
				'194.226.109.0/24' => 'GigabitEthernet0/2.239',
				'194.226.129.0/24' => 'Gi0/2.753',
				'195.208.36.0/24' => 'Gi0/2.151',
				'62.76.94.0/24' => 'Gi0/2.184',
				'92.241.15.0/24' => 'Gi0/2.130',
				'92.241.17.0/24' => 'Gi0/2.136'
				}
		hh[pool]
	end

end
