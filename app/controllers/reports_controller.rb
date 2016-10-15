# -*- encoding : utf-8 -*-
class ReportsController < ApplicationController
  include ReportsHelper
  include ApplicationHelper
  before_filter :authorize
  helper_method :sort_column, :sort_direction
  
  def show
    @rep_num = params[:id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  def index
  end

  def pporep
    @pporep= if @staff_login.admin? || @staff_login.groupid.include?(2)
               PpoReport.where(filter_pporep).search(params[:search]).order(sort_column + " " + sort_direction)
             elsif @staff_login.groupid.include?(6)
               PpoReport.where("flag='DT'").search(params[:search]).order(sort_column + " " + sort_direction)
             elsif @staff_login.groupid.include?(3)
               PpoReport.where("flag='DD'").search(params[:search]).order(sort_column + " " + sort_direction)
             else
               PpoReport.where(filter_pporep).search(params[:search]).order(sort_column + " " + sort_direction)
             end
     if @staff_login.gr_names == ["Отдел продаж ЦД"]
       @pporep= case @staff_login.fullname
                when /Антропов|Долгин/
                  @pporep.where(manager: ['Антропов Константин','ИП Эндер'])
                when /Макарова/
                  @pporep.where(manager: ['Макарова Ирина','ООО "Медиа 161"','ИП Щербина','ИП Волчанская'])
                when /Ваганов/
                  @pporep.where(manager: ['Ваганов Андрей','ИП Адаменко','ИП Долгин','АК Спецсвязь'])
                when /Гученко/
                  @pporep.where(manager: ['Гученко Наталья','АК Спецсвязь','СТС'])
				else
				   @pporep
                end
     end

     @pporep= @pporep.where(manager: @staff_login.fullname) if @staff_login.gr_names == ["Отдел продаж ДТ"]

     @pporep= @pporep.where("flag=?",params[:flag]) if (not params[:flag].nil?) && (not params[:flag].empty?)
     @pporep= @pporep.where("type_t=?",params[:type_t]) if (not params[:type_t].nil?) && (not params[:type_t].empty?)
     @pporep= @pporep.where("type_t='ppomap'")
     @pporep= @pporep.paginate(:per_page => 28, :page => params[:page]) unless params[:pg]=="off"

  end

  def wifipporep
    @wifipporep= if @staff_login.groupid.include?(6)
               if params[:pg]=="off"
                 WifiPpoReport.where("flag='DT'").search(params[:search]).order(sort_column + " " + sort_direction)
               else
                 WifiPpoReport.where("flag='DT'").search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
               end
              elsif @staff_login.groupid.include?(3)
               if params[:pg]=="off"
                 WifiPpoReport.where("flag='DD'").search(params[:search]).order(sort_column + " " + sort_direction)
               else
                 WifiPpoReport.where("flag='DD'").search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
               end
              else
               if params[:pg]=="off"
                 WifiPpoReport.where(filter_pporep).search(params[:search]).order(sort_column + " " + sort_direction)
               else
                 WifiPpoReport.where(filter_pporep).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
               end
             end
     @wifipporep= @wifipporep.where(manager: @staff_login.fullname) if @staff_login.gr_names == ["Отдел продаж ЦД"] || @staff_login.gr_names == ["Отдел продаж ДТ"]
     @wifipporep= @wifipporep.where("flag=?",params[:flag]) if (not params[:flag].nil?) && (not params[:flag].empty?)
     @wifipporep= @wifipporep.where("type_t=?",params[:type_t]) if (not params[:type_t].nil?) && (not params[:type_t].empty?)
     @wifipporep= @wifipporep.where("type_t='wifippomap'")
  end

  def installrep
    @installrep= PpoReport.select("cl_id,cl_name,t_name,manager,flag,target,income,type_t,type_s,cast(t1cr as date) as t1cr,cast(t1ch as date) as t1ch,t1s,t1r,cast(t2cr as date) as t2cr,cast(t2ch as date) as t2ch,t2s,t2r,cast(t3cr as date) as t3cr,cast(t3ch as date) as t3ch,t3s,t3r,cast(t4cr as date) as t4cr,cast(t4ch as date) as t4ch,t4s,t4r,t4dog_date,t4dog_num,t4_i_pay,t4_e_pay,cast(t5cr as date) as t5cr,cast(t5ch as date) as t5ch,t5s,t5r,cast(t5cl as date) as t5cl,cast(t6cr as date) as t6cr,cast(t6ch as date) as t6ch,t6s,t6r,cast(t7cr as date) as t7cr,cast(t7ch as date) as t7ch,t7s,t7r,t7res1date,t7res2date,cast(t8cr as date) as t8cr,cast(t8ch as date) as t8ch,t8s,t8r,t8res1date,cast(t9cr as date) as t9cr,cast(t9ch as date) as t9ch,t9s,t9r,flag1").where("(t4s='end' or t5s='end') and (isnull(t9s) or t9s='new' or t9s='run') AND (type_s='Интернет' OR type_s='Покупка ВОК' OR type_s='Аренда ВОК' OR type_s='VLAN' OR type_s='Телефония') AND t4s!='end1'")
    @installrep = @installrep.where(" not cl_id=15")
    @installrep= if @staff_login.groupid.include?(2) || @staff_login.admin?
                   @installrep
                 elsif @staff_login.groupid.include?(3) 
                   @installrep.where("flag='DD'")
                 elsif @staff_login.groupid.include?(6)
                   @installrep.where("flag='DT'")
                 else
                   @installrep
                 end
    if @staff_login.gr_names == ["Отдел продаж ЦД"]
      @installrep= case @staff_login.fullname
                   when /Антропов|Долгин/
                     @installrep.where(manager: ['Антропов Константин','ИП Эндер'])
#                   when /Макарова/
#                     @installrep.where(manager: ['Макарова Ирина','ООО "Медиа 161"','ИП Щербина','ИП Волчанская'])
                   when /Ваганов/
                     @installrep.where(manager: ['Ваганов Андрей','ИП Адаменко','ИП Долгин','АК Спецсвязь'])
                   when /Гученко/
                     @installrep.where(manager: ['Гученко Наталья','АК Спецсвязь','СТС'])
				   else
				     @installrep
                   end
    end
     @installrep= @installrep.where(manager: @staff_login.fullname) if @staff_login.gr_names == ["Отдел продаж ДТ"]
     @installrep= if params[:flag].nil? || params[:flag].empty?
                    @installrep
                  else
                    @installrep.where(flag: params[:flag])
                  end
     @installrep= case params[:type]
                  when 'ppomap'
                    @installrep.where("type_t='ppomap'")
                  when 'wifippomap'
                    @installrep.where("type_t='wifippomap'")
                  when 'voice'
                    @installrep.where("type_t='voice'")
                  else
                    @installrep
                  end
     @installrep= case params[:status]
                  when 'run'
                    @installrep.where("not t7s='end' or isnull(t7s) or not t8s='end' or isnull(t8s)")
                  when 'end'
                    @installrep.where("type_t='voice' AND t8s='end' OR t7s='end' and t8s='end'")
                  when 'end1'
                    @installrep.where("t9s='end'")
                  else
                    @installrep
                  end
     @installrep= @installrep.search(params[:search]).order(sort_column + " " + sort_direction)
     respond_to do |format|
       format.html
       format.xls
     end
  end

  def closeakt
    @d1 = params[:d1].nil? ? (Time.now - 3600*24*7).strftime("%Y-%m-%d") : params[:d1]
    @d2 = params[:d2].nil? ? Time.now.strftime("%Y-%m-%d") : params[:d2]
    @installrep= PpoReport.select("cl_id,cl_name,t_name,manager,flag,target,income,type_t,type_s,cast(t1cr as date) as t1cr,cast(t1ch as date) as t1ch,t1s,t1r,cast(t2cr as date) as t2cr,cast(t2ch as date) as t2ch,t2s,t2r,cast(t3cr as date) as t3cr,cast(t3ch as date) as t3ch,t3s,t3r,cast(t4cr as date) as t4cr,cast(t4ch as date) as t4ch,t4s,t4r,t4dog_date,t4dog_num,t4_i_pay,t4_e_pay,cast(t5cr as date) as t5cr,cast(t5ch as date) as t5ch,t5s,t5r,cast(t5cl as date) as t5cl,cast(t6cr as date) as t6cr,cast(t6ch as date) as t6ch,t6s,t6r,cast(t7cr as date) as t7cr,cast(t7ch as date) as t7ch,t7s,t7r,t7res1date,t7res2date,cast(t8cr as date) as t8cr,cast(t8ch as date) as t8ch,t8s,t8r,t8res1date,cast(t9cr as date) as t9cr,cast(t9ch as date) as t9ch,t9s,t9r,flag1").where("t9s='end'")
    @installrep = @installrep.where("DATE(t9ch) >= ? AND DATE(t9ch) <=?",@d1,@d2)
#    installrep
    @installrep = @installrep.where(" not cl_id=15")
    @installrep= if @staff_login.groupid.include?(2) || @staff_login.admin?
                    @installrep
                 elsif @staff_login.groupid.include?(3)
                    @installrep.where("flag='DD'")
                 elsif @staff_login.groupid.include?(6)
                    @installrep.where("flag='DT'")
                 else
                     @installrep
                 end
    if @staff_login.gr_names == ["Отдел продаж ЦД"]
        @installrep= case @staff_login.fullname
                 when /Антропов|Долгин/
                   @installrep.where(manager: ['Антропов Константин','ИП Эндер'])
                 when /Макарова/
                   @installrep.where(manager: ['Макарова Ирина','ООО "Медиа 161"','ИП Щербина','ИП Волчанская'])
                 when /Ваганов/
                   @installrep.where(manager: ['Ваганов Андрей','ИП Адаменко','ИП Долгин','АК Спецсвязь'])
                 when /Гученко/
                   @installrep.where(manager: ['Гученко Наталья','АК Спецсвязь','СТС'])
                 end
    end
    @installrep= @installrep.where(manager: @staff_login.fullname) if @staff_login.gr_names == ["Отдел продаж ДТ"]
    @installrep= if params[:flag].nil? || params[:flag].empty?
                   @installrep
                 else
                   @installrep.where(flag: params[:flag])
                 end
     @installrep= case params[:type]
                  when 'ppomap'
                    @installrep.where("type_t='ppomap'")
                  when 'wifippomap'
                    @installrep.where("type_t='wifippomap'")
                  when 'voice'
                    @installrep.where("type_t='voice'")
                  else
                    @installrep
                  end

                                                                                          
     respond_to do |format|
         format.html
         format.xls
    end
  end

  def newclient
    @d1 = params[:d1].nil? ? (Time.now - 3600*24*7).strftime("%Y-%m-%d") : params[:d1]
    @d2 = params[:d2].nil? ? Time.now.strftime("%Y-%m-%d") : params[:d2]
    @cl_ppo = Client.joins("LEFT JOIN ppo_report ON clients.cl_id = ppo_report.cl_id").select("clients.cl_id as cl_id, clients.name as name, clients.address as address, ppo_report.type_s as type_s, ppo_report.target as target, clients.cl_src as cl_src, clients.manager as manager, clients.date_add as date_add, clients.flag as flag, ppo_report.t_name t_name").where("DATE(date_add) >= ? AND DATE(date_add) <=?",@d1,@d2)
    @cl_ppo= if @staff_login.groupid.include?(6)
               @cl_ppo.where("clients.flag='DT'")
             elsif !@staff_login.admin? && !@staff_login.groupid.include?(2) && !@staff_login.groupid.include?(11)
               if @staff_login.gr_names == ["Отдел продаж ЦД"]
                 @cl_ppo.where("clients.flag='DD'").where(manager: @staff_login.fullname)
               else
                 @cl_ppo.where("clients.flag='DD'")
               end
             else
               @cl_ppo
             end
    @cl_ppo = @cl_ppo.where("clients.flag=?",params[:flag]) if !params[:flag].nil? && !params[:flag].empty?
    @cl_ppo = @cl_ppo.order(sort_column + " " + sort_direction)
#    @cl_ppo = @cl_ppo.paginate(:per_page => 28, :page => params[:page]) unless params[:pg]=="off"
     respond_to do |format|
         format.html
         format.xls
    end
  end

  def dogimrep
    @clients = Client.joins("LEFT JOIN ppo_report ON clients.cl_id = ppo_report.cl_id")
    @clients = if @staff_login.groupid.include?(6)
                 @clients.where("ppo_report.dogim='yes' AND (ppo_report.t4s!='end' OR ppo_report.t4s is null) AND clients.flag='DT'")
               elsif  @staff_login.admin? || @staff_login.groupid.include?(2)
                 if params[:flag].nil? || params[:flag].empty?
                   @clients.where("ppo_report.dogim='yes' AND (ppo_report.t4s!='end' OR ppo_report.t4s is null)")
                 else
                   @clients.where("clients.flag=? AND ppo_report.dogim='yes' AND (ppo_report.t4s!='end' OR ppo_report.t4s is null)",params[:flag])
                 end
               else
                 @clients.where("ppo_report.dogim='yes' AND (ppo_report.t4s!='end' OR ppo_report.t4s is null) AND clients.flag='DD'")
               end
    if @staff_login.gr_names == ["Отдел продаж ЦД"]
      @clients= case @staff_login.fullname
                   when /Антропов|Долгин/
                      @clients.where(manager: ['Антропов Константин','ИП Эндер'])
                   when /Макарова/
                     @clients.where(manager: ['Макарова Ирина','ООО "Медиа 161"','ИП Щербина','ИП Волчанская'])
                   when /Ваганов/
                     @clients.where(manager: ['Ваганов Андрей','ИП Адаменко','ИП Долгин','АК Спецсвязь'])
                   when /Гученко/
                     @clients.where(manager: ['Гученко Наталья','АК Спецсвязь','СТС'])
                   end
    end
    @clients = @clients.where(manager: @staff_login.fullname) if @staff_login.gr_names == ["Отдел продаж ДТ"]
    @clients = @clients.select("clients.cl_id as cl_id,clients.name as name,ppo_report.t_name as address,clients.manager,DATE(ppo_report.t1cr) as dad,ppo_report.income as income").search(params[:search])
    @sum = @clients.sum('ppo_report.income')
    @clients = if params[:pg]=="off"
                 @clients.order(sort_column + " " + sort_direction)
               else
                 @clients.order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
               end
  end

  def profitlistrep
    @profitlist= if @staff_login.groupid.include?(6)
                     ProfitListReport.where("flag='DT'").search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
                 elsif @staff_login.admin? || @staff_login.groupid.include?(11)
                   if params[:flag].nil? || params[:flag].empty?
                     ProfitListReport.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
                   else
                     ProfitListReport.where("flag=?",params[:flag]).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
                   end
                 else
                     ProfitListReport.where("flag='DD'").search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
                 end
     respond_to do |format|
       format.html
       format.xls
     end
  end

  def genrep
    @genreps = GenRep.select("cl_id,name,address,mng,speed,DATE_FORMAT(time_create,'%Y-%m-%d') d_cr,DATE_FORMAT(time_change,'%Y-%m-%d') d_ch,result,type_t,status,idtask,type_s,task_close")
    @genreps = @genreps.where(mng: @staff_login.fullname) if @staff_login.gr_names == ["Отдел продаж ЦД"] || @staff_login.gr_names == ["Отдел продаж ДТ"]
    @genreps = if @staff_login.groupid.include?(6) || @staff_login.groupid.include?(12)
                 @genreps.where(flag: 'DT')
               elsif @staff_login.admin? || @staff_login.groupid.include?(2) || @staff_login.groupid.include?(4) || @staff_login.groupid.include?(8) || @staff_login.groupid.include?(11)
                 params[:flag].nil? || params[:flag].empty? ? @genreps : @genreps.where(flag: params[:flag])
               else
                 @genreps.where(flag: 'DD')
               end
    ar = filter
    fstr = ar.empty? ? "" : ar.join(" AND ")
    @genreps = @genreps.where(fstr).search(params[:search]).order(sort_column + " " + sort_direction)
    @genreps = @genreps.paginate(:per_page => 28, :page => params[:page]) unless params[:pg]=="off"
     respond_to do |format|
       format.html
       format.xls
     end

  end

  def ttmsrep
    session[:referer] = request.env["PATH_INFO"] + "?" + request.env["QUERY_STRING"]
    @ttmsreps = if @staff_login.admin? || @staff_login.groupid.include?(4) || @staff_login.groupid.include?(2)  || @staff_login.groupid.include?(8)
               TtmsClients.select("idttms,source,DATE_FORMAT(time_create,'%Y-%m-%d') d1,DATE_FORMAT(time_change,'%Y-%m-%d') d2,period,dsc,cause,recap,status,cl_id,name,root").where(filter.join(" AND ")).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
              else
                respond_to do |format|
                  format.html { redirect_to "/reports" }
                  format.json { head :no_content }
                end
 
             end
  end

  def spec_ttmsrep
    session[:referer] = request.env["PATH_INFO"] + "?" + request.env["QUERY_STRING"]
    @ttmsreps = if @staff_login.admin? || @staff_login.groupid.include?(4) || @staff_login.groupid.include?(2)  || @staff_login.groupid.include?(8)
               TtmsClients.select("cl_id,name,DATE_FORMAT(time_create,'%Y-%m') as mon, root, count(root) as cc").where("time_create> date_sub(NOW(), INTERVAL 6 month)").group("mon,cl_id,root").having("cc>1").order(sort_column + " " + sort_direction)
              else
                respond_to do |format|
                  format.html { redirect_to "/reports" }
                  format.json { head :no_content }
                end
              end
	@ttmsreps = @ttmsreps.having("mon=?",params[:mon]) unless params[:mon].nil?
  end
  
  def services
    @services = ClientPortService.where(filter_service_type).search(params[:search]).order(sort_column + " " + sort_direction)
    @services = @services.paginate(:per_page => 28, :page => params[:page]) unless request.path_parameters[:format] == 'xls'
     respond_to do |format|
       format.html
       format.xls
     end
  end

  def dhcp_update
    @services = ClientPortService.select("cl_id,name,contact,contact_tech,type_s,vlan,ipaddr,DATE_FORMAT(dhcp_update,'%Y-%m-%d %H:%i') as dd").where(type_s: ['inet','one-ip','ipunnam']).where(filter_service_type).search(params[:search]).order(sort_column + " " + sort_direction)
    @services = @services.paginate(:per_page => 28, :page => params[:page]) unless request.path_parameters[:format] == 'xls'
     respond_to do |format|
       format.html
       format.xls
     end
  end

  def typeconnect
    @clients = Client.joins("LEFT JOIN services ON clients.cl_id=services.cl_id").select("clients.cl_id,clients.name,clients.city,clients.address,clients.connect_type,COUNT(services.serv_id) as sc").group("services.cl_id").having("COUNT(services.cl_id)>0").search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 28, :page => params[:page])
     respond_to do |format|
       format.html
       format.xls
     end
  end

  def newzakaz
    t0 = Time.now
    t1 = Time.mktime(t0.year,t0.mon-1)
    t2 = Time.mktime(t0.year,t0.mon)-3600
    @d1 = params[:d1].nil? ? t1.strftime("%Y-%m-%d") : params[:d1]
    @d2 = params[:d2].nil? ? t2.strftime("%Y-%m-%d") : params[:d2]
    @cl_ppo = Client.joins("LEFT JOIN ppo_report ON clients.cl_id = ppo_report.cl_id").select("clients.cl_id as cl_id, clients.name as name, ppo_report.t_name as address, ppo_report.type_s as type_s, ppo_report.target as target, clients.cl_src as cl_src, clients.manager as manager, t4dog_date as date_add, clients.flag as flag, ppo_report.t4_i_pay as ipay, ppo_report.t4_e_pay as epay").where("not isnull(t4s) AND DATE(date_add) >= ? AND DATE(date_add) <=?",@d1,@d2)
    @cl_ppo = @cl_ppo.where(manager: @staff_login.fullname) if @staff_login.gr_names == ["Отдел продаж ЦД"] || @staff_login.gr_names == ["Отдел продаж ДТ"]
    @cl_ppo= if @staff_login.groupid.include?(6)
               @cl_ppo.where("clients.flag='DT'")
             elsif !@staff_login.admin? && !@staff_login.groupid.include?(2)
               @cl_ppo.where("clients.flag='DD'")
             else
               @cl_ppo
             end
    @cl_ppo = @cl_ppo.where("clients.flag=?",params[:flag]) if !params[:flag].nil? && !params[:flag].empty?
    @cl_ppo = @cl_ppo.order(sort_column + " " + sort_direction)
#    @cl_ppo = @cl_ppo.paginate(:per_page => 28, :page => params[:page]) unless params[:pg]=="off"

    filename = Time.now.strftime("%Y-%m-%d") + " - newzakaz"
    respond_to do |format|
      format.html
      format.csv {  send_data Iconv.conv("utf-16le", "utf-8", "\xEF\xBB\xBF") + Iconv.conv("utf-16le","utf-8",generate_csv(@cl_ppo.all, col_sep: ";")),:filename => filename+".csv" }
      format.xls # {  send_data Iconv.conv("utf-16le", "utf-8", "\xEF\xBB\xBF") + Iconv.conv("utf-16le","utf-8",generate_csv(@cl_ppo.all, col_sep: "\t")),:filename => filename+".xls" }
    end

  end

  def freephones
    @freephones = TypePhoneNumber.joins("LEFT JOIN services ON type_phone_numbers.phone=services.ipaddr").where("serv_id is NULL").select("phone,type_p").where(filter_phone_type).search(params[:search]).order(sort_column + " " + sort_direction)
    @freephones = @freephones.paginate(:per_page => 28, :page => params[:page]) unless request.path_parameters[:format] == 'xls'
     respond_to do |format|
       format.html
       format.xls
     end
  end

  def wifiweek
    @d1 = params[:d1].nil? ? Time.now.strftime("%Y-%m-%d") : params[:d1]
    @wifiweeks = []
    type_desc = {"'wifippomap'"=>"Новых ППО-карт","'wifippoobj'"=>"Новых ППО объектов","'wifizakaz' AND status='end'"=>"Подписанных договоров","'wifiinstall'"=>"Инсталляций"}
    ["'wifippomap'","'wifippoobj'"].each do |task_t|
      newppo = Task.where("WEEK(time_create,1)=#{Date.parse(@d1).cweek} AND type_t="+task_t).all
      sum = newppo.collect {|t| $1.gsub(/\s/,'').to_i if t.result=~/([\d\s]+)/}.compact.sum
      @wifiweeks.push([type_desc[task_t],newppo.count,sum])
    end
    newppo = Task.where("WEEK(time_create,1)=#{Date.parse(@d1).cweek} AND type_t='wifizakaz' AND status='end'").all
    sum = newppo.collect {|t| $1.gsub(/\s/,'').to_i if t.flag=~/([\d\s]+)/}.compact.sum
    @wifiweeks.push(["Подписанных договоров",newppo.count,sum])
    newppo = WifiPpoReport.where("WEEK(t6cr,1)=#{Date.parse(@d1).cweek} AND t6s='end'").all
    sum = newppo.collect {|t| $1.gsub(/\s/,'').to_i if t.t4_e_pay=~/([\d\s]+)/}.compact.sum
    @wifiweeks.push(["Инсталляций",newppo.count,sum])
    respond_to do |format|
       format.html
       format.xls
    end
  end
#===================================================================================================
  def filter
    filter=[]
    str =  if params[:type_t].nil?
             ""
           elsif params[:type_t].length>1
             "(type_t='"+params[:type_t].join("' OR type_t='")+"')"
           elsif ! params[:type_t][0].empty?
             "type_t='"+params[:type_t][0]+"'"
           else
             ""
           end
    filter.push str unless str.empty?
    str=""
    str = if params[:status].nil?
            ""
          elsif params[:status].length>1
            "(status='"+params[:status].join("' OR status='")+"')"
          elsif ! params[:status][0].empty?
            "status='"+params[:status][0]+"'"
          else
            ""
          end
     filter.push str unless str.empty?
    str=""
    str = if params[:root].nil?
            ""
          elsif params[:root].length>1
            "(root='"+params[:root].join("' OR root='")+"')"
          elsif ! params[:root][0].empty?
            "root='"+params[:root][0]+"'"
          else
            ""
          end
     filter.push str unless str.empty?

	 
     filter.push "DATE(time_create)>='"+params[:d1]+"'" unless params[:d1].nil? || params[:d1].empty?
     filter.push "DATE(time_create)<='"+params[:d2]+"'" unless params[:d2].nil? || params[:d2].empty?
     filter.push "DATE(time_change)>='"+params[:d3]+"'" unless params[:d3].nil? || params[:d3].empty?
     filter.push "DATE(time_change)<='"+params[:d4]+"'" unless params[:d4].nil? || params[:d4].empty?
     filter.push "DATE(task_close)<='"+params[:d6]+"'" unless params[:d6].nil? || params[:d6].empty?
     filter.push "DATE(task_close)>='"+params[:d5]+"'" unless params[:d5].nil? || params[:d5].empty?

logger.debug filter
     filter
  end
 
  def filter_pporep
    str=""
    str = if params[:status].nil?
            ""
          elsif params[:status].length>1
            ar=[]
            1.upto(5) { |i| ar.push "t#{i}s='"+params[:status].join("' OR t#{i}s='")+"'"}
            ar.join(" OR ")
          elsif ! params[:status][0].empty?
            ar=[]
            1.upto(5) { |i| ar.push "t#{i}s='"+params[:status][0]+"'"}
            ar.join(" OR ")
          else
            ""
          end
logger.debug str
     str
  end

  def filter_service_type
    str=""
    str = if params[:type_s].nil? ||  params[:type_s].empty?
            ""
          elsif params[:type_s].length>0
            ar=[]
            params[:type_s].each { |tt| ar.push "type_s='#{tt}'" }
            ar.join(" OR ")
          else
             logger.debug "params[:type_s]=#{params[:type_s].inspect}"
            ""
          end
#logger.debug "filter str=#{str.inspect}"
     str
  end

  def filter_phone_type
    str=""
    str = if params[:type_p].nil? ||  params[:type_p].empty?
            ""
          elsif params[:type_p].length>0
            ar=[]
            params[:type_p].each { |tt| ar.push "type_p='#{tt}'" }
            ar.join(" OR ")
          else
             logger.debug "params[:type_p]=#{params[:type_p].inspect}"
            ""
          end
#logger.debug "filter str=#{str.inspect}"
     str
  end

  def sort_column
    %w[root cl_name t_name manager target t1cr t2cr t3cr t4cr t5cr idttms source name address d1 d2 dsc cause recap status period city date_add idtask result d_ch d_cr type_t flag cl_id ipaddr speed vlan cl_port t2d t3d income dogovor_date dogovor_num pay cl_src type_p phone dad dd mon].include?(params[:sort]) ? params[:sort] : "cl_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
