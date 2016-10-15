class PpoLogsController < ApplicationController
  def index
    @ppologs= PpoLog.where(cl_id: params[:cl_id]).search(params[:search]).order(sort_column + " " + sort_direction)
    @client = Client.find(params[:cl_id])
    @comment = Comment.new
    @erpfile = Erpfile.new
  end

  def create
  end

  def new
    @client = Client.find(params[:cl_id])
    @ppolog = PpoLog.new(cl_id: params[:cl_id], t_name: @client.address, type_s: params[:type_s] )
  end

  def edit
    @ppolog = PpoLog.find(params[:id])
    @client = @ppolog.client
  end

  def update
    @ppolog = PpoLog.find(params[:id])
    case(params[:type_t])
      when 'ppomap'
        @ppolog.t1ch = Time.now.getlocal
      when 'ppoobj'
        @ppolog.t2cr = Time.now.getlocal if @ppolog.t2cr.nil?
        @ppolog.t2ch = Time.now.getlocal
        @ppolog.flag1 = "" if params[:flag1].nil?
      when 'sogl'
        @ppolog.t3cr = Time.now.getlocal if @ppolog.t3cr.nil?
        @ppolog.t3ch = Time.now.getlocal
      when 'zakaz'
        @ppolog.t4cr = Time.now.getlocal if @ppolog.t4cr.nil?
        @ppolog.t4ch = Time.now.getlocal
      when /pay/
        @ppolog.t5cr = Time.now.getlocal if @ppolog.t5cr.nil?
        @ppolog.t5ch = Time.now.getlocal
      when 'shem'
        @ppolog.t6cr = Time.now.getlocal if @ppolog.t6cr.nil?
        @ppolog.t6ch = Time.now.getlocal
      when 'install'
        @ppolog.t7cr = Time.now.getlocal if @ppolog.t7cr.nil?
        @ppolog.t7ch = Time.now.getlocal
      when 'install1'
        @ppolog.t8cr = Time.now.getlocal if @ppolog.t8cr.nil?
        @ppolog.t8ch = Time.now.getlocal
      when 'akt'
        @ppolog.t9cr = Time.now.getlocal if @ppolog.t9cr.nil?
        @ppolog.t9ch = Time.now.getlocal
    end
    respond_to do |format|
      if @ppolog.update_attributes(params[:ppo_log])
        format.html { redirect_to ppo_logs_path(:cl_id => @ppolog.cl_id), notice: 'Erpfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ppolog.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
  end

  def show
  end

  def sort_column
    %w[cl_name t_name manager target t1cr t2cr t3cr t4cr t5cr idttms source name address d1 d2 dsc cause recap status period city date_add idtask result d_ch d_cr type_t flag cl_id ipaddr speed vlan cl_port t2d t3d income dogovor_date dogovor_num pay cl_src].include?(params[:sort]) ? params[:sort] : "cl_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
