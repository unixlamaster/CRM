# -*- encoding : utf-8 -*-
module ClientsHelper
  def client_source_hash
    Hash['internet','Интернет',
     '2gis','2ГИС',
     'manager','Менеджер',
     'avto','Авто',
     'recomend','Рекомендации',
     'corp_site','Заявка с корпоративного сайта',
     'info_mail','Заявка на почтовый ящик info',
     'inet_reklam','Интернет реклама',
     'nag.ru','Сайт nag.ru/4geo',
     'smi','СМИ глянец',
     'tabl_opora','Таблички на опорах',
     'plakati','Плакаты в зданиях',
     'Instagram','Instagram',
     'world_class','World class',
     'stiker','Стикер на оборудовании',
	'chat','Чат на сайте',
	'bc_reklam','Реклама в БЦ',
	'flaer','Флаер',
	'teatr18','Театр 18+']
  end

  def authorize
logger.debug "########## request.parameters[action]="+request.parameters["action"].inspect
    if !@staff_login.admin?
      case request.parameters["action"]
        when /index|new|create/
#           true
        when /edit|update/
#          if @staff_login.groupid.include?(6) && Client.find(params[:id]).flag=='DD' || !@staff_login.groupid.include?(6) && Client.find(params[:id]).flag=='DT'
#            redirect_to clients_path, flash: { error: "Недостаточно прав" }
#            false
#          else
            true
#          end
        when /show/
#          if @staff_login.groupid.include?(4)
            true
#          else
#            if @staff_login.groupid.include?(6) && Client.find(params[:id]).flag=='DD' || !@staff_login.groupid.include?(6) && Client.find(params[:id]).flag=='DT'
#               redirect_to clients_path, flash: { error: "Недостаточно прав" }
#               false
#             else
#              true
 #           end
#          end
        when /edit|update|destroy/
          if @staff_login.admin?
            true
          else
            redirect_to clients_path, flash: { error: "Недостаточно прав" }
            false
          end
      end
    else
#      true
    end
  end

  def client_DDDT_hash
    Hash["DD","Цифровой Диалог","DT","Диалог Телеком"]
  end

  def connect_type_array
    ["","Узел ISCOM-2924","Узел ISCOM-2110","MC-100, DGS-1100","MC-100","MC-100, DIR-100"]
  end

  def task_type_image_helper
    Hash['t1s',"/images/location.png",
         't2s',"/images/home.png",
         't3s',"/images/clipboard.png",
         't4s',"/images/zakaz.png",
         't5s',"/images/dollar.png",
         't6s',"/images/random.png",
         't7s',"/images/hammer.png",
         't8s',"/images/screwdriver.png",
         't9s',"/images/finish.png",
        ]
  end
end
