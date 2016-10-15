# -*- encoding : utf-8 -*-
class TasksController < ApplicationController
  include TasksHelper
  before_filter :authorize
  helper_method :sort_column, :sort_direction
  # GET /tasks
  # GET /tasks.json
  def index
#    filter = ""
    session[:referer] = request.env["PATH_INFO"] + "?" + request.env["QUERY_STRING"]
    @task = if params[:cl_id].nil?
              Task.search(params[:search])
            elsif params[:search]
              Task.where(["cl_id=? AND name LIKE ?",params[:cl_id],"%#{params[:search]}%"]).order("zapros_gid desc,point_group desc,idtask asc").paginate(:per_page => 30, :page => params[:page])
            else
              Task.where(["cl_id=?",params[:cl_id]]).order("zapros_gid desc,point_group desc,idtask asc").paginate(:per_page => 30, :page => params[:page])
            end
    @client = Client.find(params[:cl_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @client = Client.find(params[:cl_id])
    @task = Task.find(params[:id])
    if @task.type_t =~ /^wifi/
      @task.update_attribute(:status, "run") if @task.status=="new" && dt_check_permit(@staff_login,"update",@task.type_t,@client)
    else
      @task.update_attribute(:status, "run") if @task.status=="new" && dd_check_permit(@staff_login,"update",@task.type_t,@client)
    end
    @erpfiles = Erpfile.where(idtask: @task.id)
    @erpfile = Erpfile.new
    @comment = Comment.new
    @comments = Comment.where(idtask: Task.where(cl_id: @task.cl_id, point_group: @task.point_group, zapros_gid: @task.zapros_gid).collect(&:idtask)).order("time desc")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @client = Client.find(params[:cl_id])
    @task = Task.new(cl_id: params[:cl_id], type_t: params[:type_t], status: params[:status])
    @task.status = "new" if @task.status.nil?
    if ! params[:point_group].nil? && ! params[:point_group].to_s.empty?
      pred_t = Task.where(point_group: params[:point_group]).last
      @task.name = pred_t.name
      @task.type_s = params[:type_s].nil? ?  pred_t.type_s : params[:type_s]
      @task.target = pred_t.target
      @task.point_group = params[:point_group]
      @task.zapros_gid = pred_t.zapros_gid
    else
      @task.name = @client.address
      @task.zapros_gid = params[:zapros_gid]
      @task.type_s = params[:type_s]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @client = Client.find(params[:cl_id])
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.autor = @staff_login.id
    @task.from_userid = @staff_login.id
    @task.current_staff = @staff_login
    @client = Client.find(params[:task][:cl_id])
    @task.name = @client.address if @task.name.empty?
    @task.status = "new" if @task.status.nil?
    @task.time_create = Time.now.getlocal
    @task.point_group = Task.maximum('point_group').to_i+1 if @task.point_group.nil? || @task.point_group.to_s.empty?
    @task.zapros_gid = Task.maximum('zapros_gid').to_i+1 if @task.zapros_gid.nil? || @task.zapros_gid.to_s.empty?
    @task.target = if @task.target.empty? || (@task.target=~/[\d]+/).nil?
                     "0"
                   else
                      /([\d]+)/.match(@task.target)[1]
                   end
    respond_to do |format|
		Task.transaction do
			begin
				@task.save
				if @task.type_t == 'upgrade'
					if (shema = Task.where(point_group: @task.point_group, type_t: 'shem').first) != nil
						shema.update_attributes({status: 'run',target: @task.target})
					end
				end
				format.html { redirect_to "/tasks/?cl_id=#{@client.id}", notice: 'Task was successfully created.' }
				format.json { render json: @task, status: :created, location: @task }
			rescue
				format.html { render action: "new" }
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    @task.from_userid = @staff_login.id
    @client = Client.find(@task.cl_id)
    @task.time_change = Time.now.getlocal
    @task.name = @client.address if @task.name.empty?
    @task.current_staff = @staff_login
    params[:task][:status] = "run" if @task.type_t == "zakaz" && Erpfile.where(idtask: @task.id).count==0
    params[:task][:res1_date] = Time.now.getlocal.strftime("%F") if @task.type_t == "install" && @task.status == "end0"
    respond_to do |format|
#      if @task.update_attributes(params.require(:task).permit(:status, :res1_date, :result))
		if ( @task.type_t == "zakaz" || @task.type_t == "arenda") && Erpfile.where(idtask: @task.id).count==0
          format.html { redirect_to task_path(@task.idtask,cl_id: @task.cl_id), flash: { error: 'Для закрытия задачи необходимо приложить договор'} }
        elsif @task.update_attributes(params[:task])
			if @task.type_t == "install1" && @task.status == "end"
				Mailer.email_task_end(@staff_login,@client,@task,PpoReport.where({ cl_id: @task.cl_id, zapros_gid: @task.zapros_gid, point_group: @task.point_group}).first).deliver
			elsif @task.type_t =~ /zakaz/ && @task.status == "end1"
				Mailer.email_task_end1(@staff_login,@client,@task).deliver
			else
				Mailer.email_task_status(@staff_login,@client,@task,Comment.where(idtask: @task.id),Erpfile.where(idtask: @task.id)).deliver if @task.status == "end"
			end

			@client.update_attributes({flag2: ""}) if @task.type_t =~ /zakaz/ && @task.status == "end"

			mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: task_action_parser(@client,@task))
			mnglog.save
			if @task.type_t == "install1" && @task.status == "end" && ! Task.exists?(cl_id: @task.cl_id, point_group: @task.point_group, zapros_gid: @task.zapros_gid, type_t: "akt")
				@akt_t = Task.new(params[:task])
				@akt_t.type_t = "akt"
				@akt_t.status = "new"
				@akt_t.name = @task.name
				@akt_t.target = @task.target
				@akt_t.type_s = @task.type_s
				@akt_t.current_staff = @staff_login
				@akt_t.autor = @task.autor
				@akt_t.point_group = @task.point_group
				@akt_t.zapros_gid = @task.zapros_gid
				@akt_t.from_userid = @task.autor
				@akt_t.time_create = Time.now.getlocal
				@akt_t.dead_line = (Time.now.getlocal+3600*24*14).strftime("%Y-%m-%d")
				@akt_t.save
				@client.flag2=""
				@client.save
				mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: task_action_parser(@client,@task))
				mnglog.save
			end
			if @task.type_t == "install" && @task.status == "end" && @task.type_s == "Аренда ВОК" && ! Task.exists?(cl_id: @task.cl_id, point_group: @task.point_group, zapros_gid: @task.zapros_gid, type_t: "akt")
				@akt_t = Task.new(params[:task])
				@akt_t.type_t = "akt"
				@akt_t.status = "new"
				@akt_t.name = @task.name
				@akt_t.target = @task.target
				@akt_t.type_s = @task.type_s
				@akt_t.autor = @task.autor
				@akt_t.current_staff = @staff_login
				@akt_t.point_group = @task.point_group
				@akt_t.zapros_gid = @task.zapros_gid
				@akt_t.from_userid = @task.autor
				@akt_t.time_create = Time.now.getlocal
				@akt_t.dead_line = (Time.now.getlocal+3600*24*14).strftime("%Y-%m-%d")
				@akt_t.save
				@client.flag2=""
				@client.save
				mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: task_action_parser(@client,@task))
				mnglog.save
			end
			if @task.type_t == "shem" && @task.status == "end" && ! Task.exists?(cl_id: @task.cl_id, point_group: @task.point_group, zapros_gid: @task.zapros_gid, type_t: "install1")
				@t_t = Task.new(params[:task])
				@t_t.type_t = "install1"
				@t_t.status = "new"
				@t_t.name = @task.name
				@t_t.target = @task.target
				@t_t.type_s = @task.type_s
				@t_t.autor = @task.autor
				@t_t.current_staff = @staff_login
				@t_t.point_group = @task.point_group
				@t_t.zapros_gid = @task.zapros_gid
				@t_t.from_userid = @task.autor
				@t_t.time_create = Time.now.getlocal
				@t_t.dead_line = (Time.now.getlocal+3600*24*14).strftime("%Y-%m-%d")
				@t_t.save
				@client.flag2=""
				@client.save
				mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: task_action_parser(@client,@task))
				mnglog.save
			end
			format.html { redirect_to (session[:referer].nil? ? tasks_path(cl_id: @task.cl_id) : session[:referer]), notice: 'Task was successfully updated.' }
			format.json { head :no_content }
		else
			format.html { render action: "edit" }
			format.json { render json: @task.errors, status: :unprocessable_entity }
		end
    end
  end

  def change
    @task = Task.find(params[:id])
    @client = Client.find(@task.cl_id)
    @task.time_change = Time.now.getlocal
    @task.time_create = Time.now.getlocal if params[:task][:status] == 'new'
logger.debug params[:task]
    respond_to do |format|
      if @task.update_attributes(params[:task])
          Mailer.email_task_change_status(@staff_login,@client,@task,Comment.where(idtask: @task.id),Erpfile.where(idtask: @task.id)).deliver 
          mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: task_action_parser(@client,@task))
          mnglog.save
        format.html { redirect_to "/tasks/?cl_id=#{@task.cl_id}", notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @client = Client.find(@task.cl_id)
    @task.destroy
    mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: task_action_parser(@client,@task))
    mnglog.save

    respond_to do |format|
      format.html { redirect_to session[:referer] }
      format.json { head :no_content }
    end
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "zapros_gid,point_group,idtask"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
