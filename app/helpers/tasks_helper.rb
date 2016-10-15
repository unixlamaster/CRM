# -*- encoding : utf-8 -*-
module TasksHelper
 def task_type_hash
   Hash['ppomap','ППО-карта',
     'ppoobj','ППО-объект',
     'sogl','Согласование', 
     'zakaz','Договор', 
     'pay','Оплата', 
     'nopay','Без оплаты', 
     'shem','Схема', 
     'install','Инсталляция ВОЛС', 
     'install1','Инсталляция Сервиса',
     'akt','Подписание АКТа',
     'wifippomap','ППО-карта WiFi',
     'wifippoobj','ППО-объект WiFI',
     'wifisogl','Согласование WiFi',
     'wifizakaz','Договор WiFi',
     'wifipay','Оплата WiFi',
     'wifinopay','WiFi Без оплаты',
     'wifiinstall','Инсталляция WiFi',
     'wifiakt','Подписание АКТа WiFi',
     'voice','Телефония',
	 'arenda','Аренда',
	 'upgrade','Модернизация',
	 'test-voip','Телефон на тест'
     ]
 end

 def deadline(type)
   t = Time.now
   tr = case(type)
     when 'ppomap'
       t.wday==5 ? t+86400*3 : t+86400
     when 'ppoobj'
       t.wday>2 ? t+86400*6 : t+86400*3
     when 'sogl'
       t+86400*14
     when 'zakaz'
       t.wday==5 ? t+86400*3 : t+86400
     when 'pay'
       t.wday==5 ? t+86400*3 : t+86400
     when 'shem'
       t.wday==5 ? t+86400*3 : t+86400
     when /install|akt/
       t+86400*14
     when 'voice'
       t.wday==5 ? t+86400*3 : t+86400
   end
   tr.strftime("%Y-%m-%d")
 end

 def task_status_hash
   Hash['new',"Новая",
        'run',"Выполняется",
        'end0',"Завершены_лин_раб",
        'end',"Выполнена",
        'stop',"Приостановлен",
        'clsogl',"На согласовании у клиента",
        'end1',"Расторжение",
        'end2',"Расторгнут",
        'nopay',"Без оплаты"]
 end

 def task_vols_status_hash
   Hash['new',"Новая",
        'run',"Выполняется",
        'end0',"Завершены_лин_раб",
        'end',"Завершена_сварка"]
 end

 def task_srv_type_hash
   Hash["Интернет","Интернет",
        "VLAN","VLAN",
        "Аренда ВОК","Аренда ВОК",
        "Покупка ВОК","Покупка ВОК",
        'Телефония','Телефония']
 end

 def task_wifi_srv_type_hash
   Hash["Интернет","Интернет",
        "VLAN","VLAN" ]
 end

 def task_status_bgcolor(status)
   case(status)
     when /new|end1/
        "red"
     when 'run'
        "green"
     else
        "white"
   end
 end

 def dd_check_permit(staff,action,type_t,client)
logger.debug "staff=" << staff.inspect
logger.debug "staff.groups=" << staff.groupid.inspect
logger.debug "action=" << action
logger.debug "type_t=#{type_t}"
logger.debug "client.flag=#{client.flag}"
logger.debug "----------------------------"
    if !staff.admin?
      case action
        when /index|show/
               if staff.groupid.include?(11)
                 true
               elsif staff.groupid.include?(6) && client.flag=='DD' || staff.groupid.include?(3) && client.flag=='DT'
                 false
               else
                 true
               end
######################
				true
######################				
        when /new|create|change/
           case type_t
             when /ppo|sogl|zakaz|pay|akt|voice|test-voip/
               if staff.groupid.include?(3) || staff.groupid.include?(6) #  Отдел продаж
                 true
               else
                 false
               end
             when /shem|install/
                 true
			when /arenda|upgrade/
				true
             else
               false
           end
        when /update|edit/
          case type_t
             when /ppomap|voice|arenda|test-voip/
               true
             when /ppoobj|sogl|shem/
               if staff.groupid.include?(7) || staff.groupid.include?(4) #  Магистраль
                 true
               else
                 false
               end
             when 'install'
               if staff.groupid.include?(7) #  Магистраль
                 true
               else
                 false
               end
             when /install1|upgrade/
               if staff.groupid.include?(8) #  Магистраль
                 true
               else
                 false
               end
             when /zakaz|akt/
               if staff.groupid.include?(3) || staff.groupid.include?(6) #  Отдел продаж
                 true
               else
                 false
               end
             when /pay/
               if staff.groupid.include?(5) || staff.groupid.include?(12) #  Отдел продаж
                 true
               else
                 false
               end
             else
               false
           end
        when /destroy/
          task=Task.find(params[:id])
          if task.status=="new" && task.autor==@staff_login.id
            true
          else
            false
          end
        else
          false
      end
    else
      true
    end
 end

#======================================================================================================
 def dt_check_permit(staff,action,type_t,client)
logger.debug "staff=" << staff.inspect
logger.debug "staff.groups=" << staff.groupid.inspect
logger.debug "action=" << action
logger.debug "type_t=#{type_t}"
logger.debug "client.flag=#{client.flag}"
logger.debug "----------------------------"
    if !staff.admin?
      case action
        when /index|show/
               if staff.groupid.include?(6) && client.flag=='DD' || staff.groupid.include?(3) && client.flag=='DT' || staff.groupid.include?(11) && client.flag=='DT'
                 false
               else
                 true
               end
        when /new|create/
           case type_t
             when /ppo|sogl|zakaz|pay|shem|install|akt|voice/
               if staff.groupid.include?(6) || staff.groupid.include?(3)   #  Отдел продаж
                 true
               else
                 false
               end
             when /install/
                 true
             else
               false
           end
        when /update|edit/
          case type_t
             when /ppo|sogl/
               true
             when /shem|install/
               if staff.groupid.include?(9) ||  staff.groupid.include?(10)  #  Технический отдел
                 true
               else
                 false
               end
             when /zakaz|akt|voice/
               if staff.groupid.include?(6) || staff.groupid.include?(3) #  Отдел продаж
                 true
               else
                 false
               end
             when /pay/
               if staff.groupid.include?(5) || staff.groupid.include?(12) #  Отдел продаж
                  true
               else
                  false
               end
             else
               false
           end
        when /destroy/
          task=Task.find(params[:id])
          if task.status=="new" && task.autor==@staff_login.id
            true
          else
            false
          end
        else
          false
      end
    else
      true
    end
####################
true
####################
	
 end
#====================================================================================
  def default_user_task
    case @staff_login.id
      when 91
        "shem"
      when 133,141,130
        "install1"
      else
        "ppomap"
    end
  end

  def authorize
    req1 = params[:task]
    req2 = req1.nil? ? params : req1
    type_t = !params[:id].nil? && req2["type_t"].nil? ? Task.find(params[:id]).type_t : req2["type_t"]
    client = Client.find(params[:cl_id])
    res= if req2["type_t"] =~ /^wifi/
           dt_check_permit(@staff_login,params["action"],type_t,client)
         else
           dd_check_permit(@staff_login,params["action"],type_t,client)
         end
    redirect_to clients_path, flash: { error: "Недостаточно прав" } unless res
    res
  end
#====================================================================================
  def dd_reglament_button(task,type_t)
    case type_t
          when 'ppomap'
            ( Task.where(point_group: task.point_group, type_t: "ppoobj", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/home.png", :title =>'ППО Объект',:border=>0}, false), new_task_path(cl_id: params[:cl_id], type_t:"ppoobj", point_group: task.point_group)) : "".html_safe )
          when 'ppoobj'
            if task.status=='end'
              (if task.flag=~/sogl/
               (Task.where(point_group: task.point_group, type_t: "sogl", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/clipboard.png", :title =>'Согласование',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"sogl")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
              else
                (Task.where(point_group: task.point_group, type_t: "zakaz", cl_id: task.cl_id).count==0 ? link_to( tag("img", { :src => "/images/zakaz.png", :title =>'Договор',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"zakaz")<<"&point_group=#{task.point_group}") : "".html_safe)
              end) +  link_to( tag("img", { :src => "/images/reload.png", :title =>'Перезапустить задачу',:border=>0 }, false), task_change_path(:id=>task.id, "task[status]"=> "new", :cl_id=>task.cl_id))
            elsif task.status=='stop'
              link_to tag("img", { :src => "/images/start.gif", :title => 'Возобновить',:border=>0}, false), task_change_path(task,:task=>{:status=>"new",:type_t=>"ppoobj"},cl_id: task.cl_id)
            else
              link_to tag("img", { :src => "/images/stop.gif", :title => 'Отложить',:border=>0}, false), task_change_path(task,:task=>{:status=>"stop",:type_t=>"ppoobj"}, cl_id: task.cl_id)
            end
          when 'sogl'
            if task.status=='end'
              (Task.where(point_group: task.point_group, type_t: "zakaz", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/zakaz.png", :title =>'Договор',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"zakaz")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
            elsif task.status=='new' || task.status=='run'
              link_to tag("img", { :src => "/images/stop.gif", :title => 'Отложить',:border=>0}, false), task_change_path(task,:task=>{:status=>"stop",:type_t=>"sogl"},:cl_id=>task.cl_id)
            else
              link_to tag("img", { :src => "/images/start.gif", :title => 'Возобновить',:border=>0}, false), task_change_path(task,:task=>{:status=>"new",:type_t=>"sogl"},:cl_id=>task.cl_id)
            end
          when 'zakaz'
            if task.status=='end2'
              link_to(tag("img", { :src => "/images/random.png", :title =>'Схема',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"shem")<<"&point_group=#{task.point_group}") << "&nbsp;".html_safe
            elsif task.status=='end1'
              "".html_safe
            elsif Task.where("point_group=? AND (type_t='nopay' OR type_t='pay')", task.point_group).where(cl_id: task.cl_id).count==0
              (Task.where(point_group: task.point_group, type_t: "nopay", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/no-money.gif", :title =>'Без оплаты',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"nopay")<<"&point_group=#{task.point_group}&status=end") : "".html_safe) << "&nbsp;".html_safe <<\
              (Task.where(point_group: task.point_group, type_t: "pay", cl_id: task.cl_id).count==0 ? link_to( tag("img", { :src => "/images/dollar.png", :title =>'Оплата',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"pay")<<"&point_group=#{task.point_group}") : "".html_safe) 
            else 
              if task.status=='stop'
                link_to tag("img", { :src => "/images/start.gif", :title => 'Возобновить',:border=>0}, false), task_change_path(task,:task=>{:status=>"new",:type_t=>"zakaz"},:cl_id=>task.cl_id)
              else
                link_to tag("img", { :src => "/images/stop.gif", :title => 'Остановить',:border=>0}, false), task_change_path(task,:task=>{:status=>"stop",:type_t=>"zakaz"},:cl_id=>task.cl_id)
              end
            end 
          when /nopay|pay/
            if task.status=='end'
              if task.type_s=='Телефония'
                (Task.where(point_group: task.point_group, type_t: "shem", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/random.png", :title =>'Схема',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"shem")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
              else
                (Task.where(point_group: task.point_group, type_t: "install", cl_id: task.cl_id).count==0 ? link_to( tag("img", { :src => "/images/hammer.png", :title =>'Инсталляция ВОЛС',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"install")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe 
              end
            end
          when 'install'
              (Task.where(point_group: task.point_group, type_t: "shem", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/random.png", :title =>'Схема',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"shem")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
          when 'shem'
            if task.status=='end'
              (Task.where(point_group: task.point_group, type_t: "install1", cl_id: task.cl_id).count==0 ? link_to( tag("img", { :src => "/images/screwdriver.png", :title =>'Инсталляция Сервиса',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"install1")<<"&point_group=#{task.point_group}") : "".html_safe) +  link_to( tag("img", { :src => "/images/reload.png", :title =>'Перезапустить задачу',:border=>0 }, false), task_change_path(:id=>task.id, "task[status]"=> "new", :cl_id=>task.cl_id))
            end
          when 'install1'
            if task.status=='end'
              (Task.where(point_group: task.point_group, type_t: "akt", cl_id: task.cl_id).count==0 ? link_to("АКТ", new_task_path(:cl_id=>params[:cl_id],:type_t=>"akt")<<"&point_group=#{task.point_group}") : "".html_safe) << link_to( tag("img", { :src => "/images/reload.png", :title =>'Перезапустить задачу',:border=>0 }, false), task_change_path(:id=>task.id, "task[status]"=> "new", :cl_id=>task.cl_id)) << "&nbsp;".html_safe
            end
          when 'voice'
            (Task.where(point_group: task.point_group, type_t: "zakaz", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/zakaz.png", :title =>'Договор',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"zakaz")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
          when 'akt'
            link_to(tag("img", { :src => "/images/shredder.png", :title =>'Договор',:border=>0, :width=>18, :height=>18}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"zakaz",:status=>"end1")<<"&point_group=#{task.point_group}")
		when nil
			link_to(tag("img", { :src => "/images/buy.png", :title =>'Аренда',:border=>0}, false), new_task_path(cl_id: params[:cl_id], type_t:"arenda", point_group: task.point_group))  << "&nbsp;".html_safe <<\
			link_to(tag("img", { :src => "/images/phone.png", :title =>'Телефон на тест',:border=>0}, false), new_task_path(cl_id: params[:cl_id], type_t:"test-voip", point_group: task.point_group,type_s: 'Телефония'))  << "&nbsp;".html_safe <<\
			link_to(tag("img", { :src => "/images/upgrade.png", :title =>'Модернизация',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id], :type_t=>"upgrade", :point_group=>task.point_group))

        end
  end

#----------------------------------------------------------------------
#
  def dt_reglament_button(task)
    case task.type_t
          when /ppomap/
            link_to tag("img", { :src => "/images/home.png", :title =>'ППО Объект',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id], :type_t=>"wifippoobj")<<"&point_group=#{task.point_group}" if Task.where(point_group: task.point_group, type_t: "wifippoobj", cl_id: task.cl_id).count==0
          when /ppoobj/
            if task.status=='end'
              if task.flag=~/sogl/
               (Task.where(point_group: task.point_group, type_t: "wifisogl", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/clipboard.png", :title =>'Согласование',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"wifisogl")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
              else
                (Task.where(point_group: task.point_group, type_t: "wifizakaz", cl_id: task.cl_id).count==0 ? link_to( tag("img", { :src => "/images/zakaz.png", :title =>'Договор',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"wifizakaz")<<"&point_group=#{task.point_group}") : "".html_safe)
              end
            elsif task.status=='stop'
              link_to tag("img", { :src => "/images/start.gif", :title => 'Возобновить',:border=>0}, false), task_change_path(task,:task=>{:status=>"new",:type_t=>"wifippoobj"},:cl_id=>task.cl_id)
            else
              link_to tag("img", { :src => "/images/stop.gif", :title => 'Отложить',:border=>0}, false), task_change_path(task,:task=>{:status=>"stop",:type_t=>"wifippoobj"},:cl_id=>task.cl_id)
            end
          when /sogl/
            if task.status=='end'
              (Task.where(point_group: task.point_group, type_t: "wifizakaz", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/zakaz.png", :title =>'Договор',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"wifizakaz")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
            end
          when /zakaz/
            if Task.where("point_group=? AND (type_t='wifinopay' OR type_t='wifipay')", task.point_group).where(cl_id: task.cl_id).count==0
              (Task.where(point_group: task.point_group, type_t: "wifinopay", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/no-money.gif", :title =>'Без оплаты',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"wifinopay")<<"&point_group=#{task.point_group}&status=end") : "".html_safe) << "&nbsp;".html_safe <<\
              (Task.where(point_group: task.point_group, type_t: "wifipay", cl_id: task.cl_id).count==0 ? link_to( tag("img", { :src => "/images/dollar.png", :title =>'Оплата',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"wifipay")<<"&point_group=#{task.point_group}") : "".html_safe)
            else
              "".html_safe
            end << \
            if task.status=='stop'
              link_to tag("img", { :src => "/images/start.gif", :title => 'Возобновить',:border=>0}, false), task_change_path(task,:task=>{:status=>"new",:type_t=>"wifizakaz"},:cl_id=>task.cl_id)
            else
              link_to tag("img", { :src => "/images/stop.gif", :title => 'Остановить',:border=>0}, false), task_change_path(task,:task=>{:status=>"stop",:type_t=>"wifizakaz"},:cl_id=>task.cl_id)
            end
          when /nopay|pay/
            if task.status=='end'
              (Task.where(point_group: task.point_group, type_t: "wifiinstall", cl_id: task.cl_id).count==0 ? link_to(tag("img", { :src => "/images/screwdriver.png", :title =>'Инсталляция',:border=>0}, false), new_task_path(:cl_id=>params[:cl_id],:type_t=>"wifiinstall")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
            end
          when /install/
            if task.status=='end'
              (Task.where(point_group: task.point_group, type_t: "wifiakt", cl_id: task.cl_id).count==0 ? link_to("АКТ", new_task_path(:cl_id=>params[:cl_id],:type_t=>"wifiakt")<<"&point_group=#{task.point_group}") : "".html_safe) << "&nbsp;".html_safe
            end
        end
  end

  def task_action_parser(client,task,action=nil)
    str = case action
          when "create"
            "Создал задачу '"
          when "update"
            "Обновил задачу '"
          when "change"
            "Изменил статус задачи '"
          when "destroy"
            "Удалил задачу '"
          else
            ""
          end
    str + task_type_hash[task.type_t]+"' для клиента "+client.name+", "+task.name+", Планируемый срок:#{task.dead_line}, Статус:"+task_status_hash[task.status]+", Результат:#{task.result}"
  end
end
