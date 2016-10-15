# -*- encoding : utf-8 -*-
class ClientsController < ApplicationController
  include ClientsHelper
  before_filter :authorize
  helper_method :sort_column, :sort_direction

  # GET /clients
  # GET /clients.json
  def index
    @clients = if params[:search].nil? || params[:search].length<3
#                 ClientsPpo.where("1=2")
				 []
               else
                 ClientsPpo.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
               end 

#               if @staff_login.gr_names == ["Отдел продаж ЦД"] || @staff_login.gr_names == ["Отдел продаж ДТ"]
#                 Client.where(manager: @staff_login.fullname).search(params[:search])
#               else
#                 Client.search(params[:search])
#               end
#    @clients = @clients.order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  def list_exists
#    @clients = if @staff_login.gr_names == ["Отдел продаж ЦД"] || @staff_login.gr_names == ["Отдел продаж ДТ"]
#                  Client.where(manager: @staff_login.fullname)
#               else
#                  Client
#               end
	@clients = Client
    @clients = @clients.joins("LEFT JOIN services ON clients.cl_id=services.cl_id").select("clients.cl_id,clients.name,clients.city,clients.address,clients.manager,COUNT(services.serv_id) as sc,clients.contact").group("services.cl_id").having("COUNT(services.cl_id)>0").search(params[:search]).order(sort_column + " " + sort_direction)
    @clients = @clients.paginate(:per_page => 28, :page => params[:page]) unless params[:pg]=="off"

    respond_to do |format|
      format.html # index.html.erb
      format.xls
    end
  end

  def tasks
       @client = Client.find(params[:id])
       respond_to do |format|
         format.html # index.html.erb
         format.json { render json: @clients }
       end
  end


  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new
    @client.flag = if @staff_login.groupid.include?(6)
                     "DT"
                   else
                     "DD"
                   end
#    (@time_from,@time_to) = @client.time_work.split(/-/)
    @time_from, @time_to =  nil, nil 
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    (@time_from,@time_to) = @client.time_work.split(/-/)
  end

  # POST /clients
  # POST /clients.json
  def create
    client_time_work = params[:client][:time_from]+"-"+params[:client][:time_to]
    n_params = params[:client]
    n_params.delete("time_from")
    n_params.delete("time_to")
    @client = Client.new(n_params)
    @client.date_add = Date.today
    @client.time_work = client_time_work
    respond_to do |format|
      if @client.save
        mnglog = MngLog.new(cr_time: Time.zone.now, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Добавил нового клиента: #{@client.name} #{@client.flag}, адрес:#{@client.address}, менеджер:#{@client.manager}, доход:#{@client.income}")
        mnglog.save
        Mailer.email_new_client(@staff_login,@client).deliver
        format.html { redirect_to "/tasks/?cl_id=#{@client.id}", notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    @client.time_work = params[:client][:time_from]+"-"+params[:client][:time_to]
    n_params = params[:client]
    n_params.delete("time_from")
    n_params.delete("time_to")
    n_params.delete("date_close") if n_params["date_close"].empty?
    respond_to do |format|
      if @client.update_attributes(n_params)
        mnglog = MngLog.new(cr_time: Time.zone.now, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Обновил клиента: #{@client.name} #{@client.flag}, адрес:#{@client.address}, менеджер:#{@client.manager}, доход:#{@client.income}")
        mnglog.save
        format.html { redirect_to "/tasks/?cl_id=#{@client.id}", notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    Task.where(cl_id: @client.cl_id).destroy_all
    @client.destroy
    mnglog = MngLog.new(cr_time: Time.zone.now, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Удалил клиента: #{@client.name} #{@client.flag}, адрес:#{@client.address}, менеджер:#{@client.manager}, доход:#{@client.income}")
    mnglog.save

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  
  def client_notification
	respond_to do |format|
		str = Client.find(params[:id]).email
		if str.nil?
			format.json { render json: {res: "Не указан EMAIL !!!"} }
		else 
			ma = str.scan(/\b[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\b/i)
			if ma.length == 0
				format.json { render json: {res: "EMAIL не найден!!!"} }
			else
				Mailer.client_notification(ma.join(',')).deliver
#				logger.debug "____________________________________________________________________________"
#				logger.debug str.inspect
#				logger.debug ma.inspect
				format.json { render json: {res: "ok"} }
			end
		end
	end
  end
  
end
