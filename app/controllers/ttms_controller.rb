# -*- encoding : utf-8 -*-
class TtmsController < ApplicationController
  include TtmsHelper
#  before_filter :authorize


  def authorize
#    logger.debug "########## request.parameters[action]="+request.parameters["action"].inspect
    if @staff_login.gr_names.include?("Сервис ЦД") || @staff_login.gr_names.include?("Начальники")
      true
    else
      redirect_to clients_path, flash: { error: "Недостаточно прав" }
      false
    end
  end


  # GET /ttms
  # GET /ttms.json
  def index
    @client = Client.find(params[:cl_id]) if !params[:cl_id].nil? && !params[:cl_id].empty?

    @ttms = if params[:cl_id].nil? || params[:cl_id].empty? 
              if params[:comp_group].nil? || params[:comp_group]=='DD'
                TtmsClients.where(comp_group: 'DD').search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
              elsif params[:comp_group]=='DT'
                TtmsClients.where(comp_group: 'DT').search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
              end
            elsif params[:search]
              Ttm.select("autor,idttms,source,DATE_FORMAT(time_create,'%Y-%m-%d') d1,DATE_FORMAT(time_change,'%Y-%m-%d') d2,dsc,cause,recap,status,comp_group,root").where(["cl_id=? AND (dsc LIKE ? or cause LIKE ? or recap LIKE ?)",params[:cl_id],"%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%"]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
            else
              Ttm.select("autor,idttms,source,DATE_FORMAT(time_create,'%Y-%m-%d') d1,DATE_FORMAT(time_change,'%Y-%m-%d') d2,dsc,cause,recap,status,comp_group,root").where(["cl_id=?",params[:cl_id]]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])
            end

    session[:referer] = request.env["PATH_INFO"] + "?" + request.env["QUERY_STRING"]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ttms }
    end
  end

  # GET /ttms/1
  # GET /ttms/1.json
  def show
    @ttm = Ttm.where(idttms: params[:id]).select("idttms,dsc,status,DATE_FORMAT(time_create,'%Y-%m-%dT%H:%i') time_create,DATE_FORMAT(time_change,'%Y-%m-%dY%H:%i') time_change,source,cause,recap").first
    @client = Client.find(params[:cl_id])
    @ttmsfiles = Ttmsfile.where(idttms: @ttm.id)
    @ttmsfile = Ttmsfile.new


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ttm }
    end
  end

  # GET /ttms/new
  # GET /ttms/new.json
  def new
    @ttm = Ttm.new
    @client = Client.find(params[:cl_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ttm }
    end
  end

  # GET /ttms/1/edit
  def edit
    @ttm = Ttm.find(params[:id])
    @open = @ttm.time_create.strftime("%Y-%m-%dT%H:%M") unless @ttm.time_create.nil?
logger.debug "!!!!!!!!!!!!#{@open}"
    @close = @ttm.time_change.strftime("%Y-%m-%dT%H:%M") unless @ttm.time_change.nil?
    @client = Client.find(params[:cl_id])
  end

  # POST /ttms
  # POST /ttms.json
  def create
    @ttm = Ttm.new(params[:ttm])
    @ttm.autor = @staff_login.id
    @ttm.time_create = Time.now.getlocal if @ttm.time_create.nil?
    @ttm.time_change = Time.now.getlocal if @ttm.status == 'end'
    @ttm.comp_group = if @staff_login.groupid.include?(10)
                        "DT"
                      else
                        "DD"
                      end
    respond_to do |format|
      if @ttm.save
        Mailer.email_ttms(@ttm).deliver
        format.html { redirect_to "/ttms/?cl_id=#{@ttm.cl_id}", notice: 'TT was successfully created.' }
        format.json { render json: @ttm, status: :created, location: @ttm }
      else
        format.html { render action: "new" }
        format.json { render json: @ttm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ttms/1
  # PUT /ttms/1.json
  def update
    @ttm = Ttm.find(params[:id])
    @ttm.autor = @staff_login.id
#    @ttm.status = 'end' 
    respond_to do |format|
      if @ttm.update_attributes(params[:ttm])
        @ttm.update_attributes({"time_change"=> Time.now.getlocal}) if params[:ttm][:status] == 'end'
        Mailer.email_ttms(@ttm).deliver
        format.html { redirect_to session[:referer], notice: 'TT was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ttm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ttms/1
  # DELETE /ttms/1.json
  def destroy
    @ttm = Ttm.find(params[:id])
    @ttm.destroy

    respond_to do |format|
      format.html { redirect_to session[:referer], notice: 'TT was successfully updated.' }
      format.json { head :no_content }
    end
  end

end
