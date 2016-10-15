class StatisticsController < ApplicationController

  include ClientsHelper

  def index
    @stats = Statistic.where(otdel: params[:otdel])
    @newstat = Statistic.new(otdel: params[:otdel], week: ( Date.today-Date.today.cwday + 1))
    
    if params[:otdel] == 'marketing'
      @stats = {}
      (Date.today-Date.today.cwday + 1 - 7*30).step(Date.today,7) { |d| 
        @stats[d] = {:arr => GenRep.where(type_t: "zakaz",status:'end').where("task_close>=? AND task_close<=?",d,d+6).joins("left join clients on genrep.cl_id=clients.cl_id").where("not clients.cl_src='manager'") }
#        @stats[d][:all] = Client.where("date_add >= ? AND date_add<= ?",d,d+6).count
         @stats[d][:all] =  Client.where("date_add >= ? AND date_add<= ?",d,d+6).count(:group => :cl_src)
      }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stats }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @stat = Statistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @stat = Statistic.new(params[:statistic])
    cur_week = Date.today
    cur_week -= (cur_week.wday + 6).days
    @stat.week = cur_week 

    @stat.staff_id = @staff_login.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stat }
    end
  end

  # GET /comments/1/edit
  def edit
    @stat = Statistic.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @stat = Statistic.new(params[:statistic])
    @stat.staff_id = @staff_login.id

    respond_to do |format|
      if @stat.save
        mnglog = MngLog.new(cr_time: Time.now.getlocal, who: @staff_login.fullname+" ("+@staff_login.user+")", text: params[:statistic].inspect)
        mnglog.save
        format.html { redirect_to statistics_path(otdel: params[:statistic][:otdel]), notice: 'Add statistic' }
        format.json { render json: statistics_path, status: :created, location: @stat }
      else
        format.html { render action: "new" }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @stat = Statistic.find(params[:id])

    respond_to do |format|
      if @stat.update_attributes(params[:statistic])
        format.html { redirect_to statistics_path(otdel: params[:statistic][:otdel]), notice: 'Statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @stat = Statistic.find(params[:id])
    @stat.destroy

    respond_to do |format|
      format.html { redirect_to statistics_url(otdel: params[:otdel]) }
      format.json { head :no_content }
    end
  end
end
