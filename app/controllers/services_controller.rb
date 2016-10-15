# -*- encoding : utf-8 -*-
class ServicesController < ApplicationController
  include ServicesHelper
  helper_method :sort_column, :sort_direction
  # GET /services
  # GET /services.json

  def index
    @services = (params[:cl_id].nil? ? ClientPortService.where("type_s <> 'phone'").search(params[:search]) : ClientPortService.where(["cl_id=? AND type_s<>'phone'",params[:cl_id]])).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
    @services_phone = (params[:cl_id].nil? ? ClientPortService.where("type_s='phone'").search(params[:search]) : ClientPortService.where(["cl_id=? AND type_s='phone'",params[:cl_id]])).order(sort_column + " " + sort_direction)
    @client = Client.find(params[:cl_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
#    @client = Client.find(params[:cl_id])
    @service = Service.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
      format.tcl
    end
  end
  
  def destroy_service
#    @client = Client.find(params[:cl_id])
    @service = Service.find(params[:id])

    respond_to do |format|
      format.tcl
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    @client = Client.find(params[:cl_id])
    @service = Service.new(params[:service])
    @service.addr = @client.address if @service.addr.nil?
    (@service.ipaddr,@service.vlan,@service.pool) = case (@service.type_s )
         when 'inet'
            [get_ip4net(30),get_free_vlan(@service.type_s),nil]
         when 'pool'
            [get_ip4net(params[:mask].nil? ? 29 : params[:mask].to_i),get_free_vlan(@service.type_s),nil]
         when 'one-ip'
            get_one_ip(@client.name =~ /^Диалог-Телеком/ ? 413 : 71)
         when 'vlan'
            ["",get_free_vlan(@service.type_s),nil]
         when 'inet6'
            [get_ip6net,get_free_vlan(@service.type_s),nil]
         when 'voip'
            [get_ipnet_voip(30),get_free_vlan(@service.type_s),nil]
         when 'nat'
            vlan = get_free_vlan(@service.type_s)
            [get_nat_pool(29),vlan,nil]
		when 'ipunnam'
            get_ipunnambered(Service.where(cl_id: 1, type_s: ['one-ip','ipunnam']).where("pool like '%/24'").select("pool,count(pool) as cc").group(:pool).order(:cc).map {|p| /(\d+\.\d+\.\d+\.)(\d+)\/(\d+)/.match(p.pool)[1] })
         end
    if @service.type_s=='phone' 
      @service.speed = 1
      @service.ipaddr = get_free_phone
    end
    @service.speed = 0 if @service.speed.nil?                  
#    @service.pool = Service.where(type_s: 'pool',vlan: @service.vlan).first.ipaddr if @service.type_s=='one-ip'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    @client = Client.find(params[:cl_id])
    @service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def mikrotik_ip(action,s)
    network,mask = s.ipaddr.split(/\//)
logger.debug s.ipaddr.inspect
logger.debug action

    ar = IPAddr.new(s.ipaddr).to_range.to_a
    logger.debug Time.now
    case action
    when 'add4'
      logger.debug("ssh -l admin 10.61.0.26 \\$add4 vlan=#{s.vlan} network=\"#{network}\" mask=#{mask} ip=\"#{ar[1].to_s}\" range=\"#{ar[2].to_s}-#{ar[-2].to_s}\"")
	  `ssh -l admin 10.61.0.26 :global add4 [:parse [/system script get add_ipv4 source]]`
      `ssh -l admin 10.61.0.26 \\$add4 vlan=#{s.vlan} network=\"#{network}\" mask=#{mask} ip=\"#{ar[1].to_s}\" range=\"#{ar[2].to_s}-#{ar[-2].to_s}\"`
    when 'add6'
      logger.debug("ssh -l admin 10.61.0.26 \\$add6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}\"")
	  `ssh -l admin 10.61.0.26 :global add6 [:parse [/system script get add_ipv6 source]]`
      `ssh -l admin 10.61.0.26 \\$add6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}"`

    when 'remove4'
      logger.debug("ssh -l admin 10.61.0.26 \\$myremove4 vlan=#{s.vlan} network=\"#{network}\" ip=\"#{ar[1].to_s}\"")
	  `ssh -l admin 10.61.0.26 :global myremove4 [:parse [/system script get remove_if4 source]]`
      `ssh -l admin 10.61.0.26 \\$myremove4 vlan=#{s.vlan} network=\"#{network}\" ip=\"#{ar[1].to_s}\"`
    when 'remove6'
      logger.debug("ssh -l admin 10.61.0.26 \\$myremove6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}\"")
	  `ssh -l admin 10.61.0.26 :global myremove6 [:parse [/system script get remove_if6 source]]`
      `ssh -l admin 10.61.0.26 \\$myremove6 vlan=#{s.vlan} ipv6=\"#{s.ipaddr}\"`
    end
  end

  def create
    @client = Client.find(params[:cl_id])
    @service = Service.new(params[:service])
    @service.addr = @client.address if @service.addr.nil?
    @service.cl_id = @client.id
    @service.ipaddr = $1 if @service.type_s=='phone' && @service.ipaddr =~ /(\d+)/

    respond_to do |format|
      if @service.save
        mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Добавил сервис #{srv_type_hash[@service.type_s]} для клиента: #{@client.name} #{@client.flag}, адрес:#{@service.addr}, скорость:#{@service.speed}, ipaddr:#{@service.ipaddr}, vlan:#{@service.vlan}")
        mnglog.save
        format.html { redirect_to "/services/?cl_id=#{@client.id}", notice: @service.attributes[:notice] }
        format.json { render json: @service, status: :created, location: @service }
      else
        format.html { render action: "new" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    @service = Service.find(params[:id])
    @client = Client.find(@service.cl_id)
    respond_to do |format|
      if @service.update_attributes(params[:service])
        mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Обновил сервис #{srv_type_hash[@service.type_s]} для клиента: #{@client.name} #{@client.flag}, адрес:#{@service.addr}, скорость:#{@service.speed}, ipaddr:#{@service.ipaddr}, vlan:#{@service.vlan}")
        mnglog.save
        format.html { redirect_to "/services/?cl_id=#{params[:cl_id]}&out_fname="+@service.result_output_fname, notice: @service.attributes[:notice] }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def stop_service
    @service = Service.find(params[:id])
    @client = Client.find(@service.cl_id)
    respond_to do |format|
      if @service.update_attributes(params[:service])
         mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Остановил сервис #{srv_type_hash[@service.type_s]} для клиента: #{@client.name} #{@client.flag}, адрес:#{@service.addr}, скорость:#{@service.speed}, ipaddr:#{@service.ipaddr}, vlan:#{@service.vlan}")
         mnglog.save
         format.html { redirect_to "/services/?cl_id=#{@client.cl_id}", notice: 'Service was successfully stop.' }
         format.json { head :no_content }
      else
         format.html { render action: "edit" }
         format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def start_service
    @service = Service.find(params[:id])
    @client = Client.find(@service.cl_id)
    respond_to do |format|
      if @service.update_attributes(params[:service])
        mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Возобновил сервис #{srv_type_hash[@service.type_s]} для клиента: #{@client.name} #{@client.flag}, адрес:#{@service.addr}, скорость:#{@service.speed}, ipaddr:#{@service.ipaddr}, vlan:#{@service.vlan}")
        mnglog.save
        format.html { redirect_to "/services/?cl_id=#{@client.cl_id}", notice: 'Service was successfully start.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def ping_stat(host)
	perc = -1
	IO.popen("/sbin/ping -qn -c 4 "+host+" 2>&1").each do |str|
		if str=~/(\d+)\.(\d+)% packet loss/
			perc=$1.to_i
		end
	end
	perc
  end

	def ping_service
		service = Service.find(params[:id])
		respond_to do |format|
			format.json { render json: {'loss'=> ping_stat(service.ipaddr)} }
		end
	end
  def result_output_fname
    '/tmp/mng_service.output'
  end
  

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = Service.find(params[:id])
    @client = Client.find(@service.cl_id)
    @service.destroy
    mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Удалил сервис #{srv_type_hash[@service.type_s]} для клиента: #{@client.name} #{@client.flag}, адрес:#{@service.addr}, скорость:#{@service.speed}, ipaddr:#{@service.ipaddr}, vlan:#{@service.vlan}")
    mnglog.save
    respond_to do |format|
      format.html { redirect_to "/services/?cl_id=#{params[:cl_id]}", notice: @service.attributes[:notice] }
      format.json { head :no_content }
    end
  end

  def sort_column
    Service.column_names.include?(params[:sort]) ? params[:sort] : "serv_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
