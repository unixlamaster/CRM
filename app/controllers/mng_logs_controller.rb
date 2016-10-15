# -*- encoding : utf-8 -*-
class MngLogsController < ApplicationController
  before_filter :authorize

  def authorize
    if @staff_login.gr_names.include?("Сервис ЦД") || @staff_login.gr_names.include?("Начальники")
      true
    else
      redirect_to clients_path, flash: { error: "Недостаточно прав" }
      false
    end
  end

  # GET /mng_logs
  # GET /mng_logs.json
  def index
    @d1 = params[:d1].nil? ? (Time.now - 3600*24).strftime("%Y-%m-%d") : params[:d1]
    @d2 = params[:d2].nil? ? Time.now.strftime("%Y-%m-%d") : params[:d2]
    @mng_logs = MngLog.where("DATE(cr_time) >= ? AND DATE(cr_time) <=?",@d1,@d2).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 30, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mng_logs }
    end
  end

  # GET /mng_logs/1
  # GET /mng_logs/1.json
  def show
    @mng_log = MngLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mng_log }
    end
  end

  # GET /mng_logs/new
  # GET /mng_logs/new.json
  def new
    @mng_log = MngLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mng_log }
    end
  end

  # GET /mng_logs/1/edit
  def edit
    @mng_log = MngLog.find(params[:id])
  end

  # POST /mng_logs
  # POST /mng_logs.json
  def create
    @mng_log = MngLog.new(params[:mng_log])

    respond_to do |format|
      if @mng_log.save
        format.html { redirect_to @mng_log, notice: 'Mng log was successfully created.' }
        format.json { render json: @mng_log, status: :created, location: @mng_log }
      else
        format.html { render action: "new" }
        format.json { render json: @mng_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mng_logs/1
  # PUT /mng_logs/1.json
  def update
    @mng_log = MngLog.find(params[:id])

    respond_to do |format|
      if @mng_log.update_attributes(params[:mng_log])
        format.html { redirect_to @mng_log, notice: 'Mng log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mng_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mng_logs/1
  # DELETE /mng_logs/1.json
  def destroy
    @mng_log = MngLog.find(params[:id])
    @mng_log.destroy

    respond_to do |format|
      format.html { redirect_to mng_logs_url }
      format.json { head :no_content }
    end
  end

  def sort_column
    MngLog.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
