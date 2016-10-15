# -*- encoding : utf-8 -*-
class ErpfilesController < ApplicationController
  include TasksHelper
  # GET /erpfiles
  # GET /erpfiles.json
  def index
    @erpfiles = Erpfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @erpfiles }
    end
  end

  # GET /erpfiles/1
  # GET /erpfiles/1.json
  def show
    @erpfile = Erpfile.find(params[:id])
    directory = "task_uploads/#{@erpfile.idtask}"
    path = File.join(directory, @erpfile.name)
    send_file path, :type => "Content-Type; charset=utf-8", :disposition => 'attachment; filename="'+@erpfile.name+'"'


#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @erpfile }
#    end
  end

  # GET /erpfiles/new
  # GET /erpfiles/new.json
  def new
    @erpfile = Erpfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @erpfile }
    end
  end

  # GET /erpfiles/1/edit
  def edit
    @erpfile = Erpfile.find(params[:id])
  end

  # POST /erpfiles
  # POST /erpfiles.json
  def create
logger.debug "------------------"  
logger.debug(request.headers["CONTENT_LENGTH"])
  
    @erpfile = Erpfile.new
    @task = Task.find(params[:erpfile][:idtask])
    @client = Client.find(@task.cl_id)


    respond_to do |format|
      if request.headers["CONTENT_LENGTH"].to_i < 10485760 && @erpfile.save_file(params[:erpfile][:file],params[:erpfile][:idtask],@staff_login)
        @task.time_change = Time.now.getlocal
        @task.save
        mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Добавил файл:#{@erpfile.name} в задачу '#{task_type_hash[@task.type_t]}' клиента '#{@client.name}', #{@task.name}")
        mnglog.save
        Mailer.email_task_shem(@staff_login,@client,@task,Comment.where(idtask: @task.id),Erpfile.where(idtask: @task.id)).deliver if @task.type_t == "shem"
        format.html { redirect_to "/tasks/#{@erpfile.idtask}?cl_id=#{params[:cl_id]}" }
        format.json { render json: @erpfile, status: :created, location: @erpfile }
      else
        format.html { redirect_to "/tasks/#{@erpfile.idtask}?cl_id=#{params[:cl_id]}", flash: { error: "Файл превышает максимальный размер 10М" } }
        format.json { render json: @erpfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /erpfiles/1
  # PUT /erpfiles/1.json
  def update
    @erpfile = Erpfile.find(params[:id])

    respond_to do |format|
      if @erpfile.update_attributes(params[:erpfile])
        format.html { redirect_to @erpfile, notice: 'Erpfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @erpfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /erpfiles/1
  # DELETE /erpfiles/1.json
  def destroy
    @erpfile = Erpfile.find(params[:id])
    @task = Task.find(@erpfile.idtask)
    @client = Client.find(@task.cl_id)
#    @erpfile.destroy
    @erpfile.update_attribute(:status, "del")
    @task.time_change = Time.now.getlocal
    @task.save
    
    mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: "Удалил файл:#{@erpfile.name} в задачу '#{task_type_hash[@task.type_t]}' клиента '#{@client.name}', #{@task.name}")
    mnglog.save
    respond_to do |format|
      format.html { redirect_to "/tasks/#{@erpfile.idtask}?cl_id=#{params[:cl_id]}" }
      format.json { head :no_content }
    end
  end
end
