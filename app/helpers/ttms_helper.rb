# -*- encoding : utf-8 -*-
module TtmsHelper

  def sort_column
    %w[idttms source name address d1 d2 dsc cause recap status period].include?(params[:sort]) ? params[:sort] : "idttms"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def ttms_status_hash
    Hash['new','Новое',
        'run','В работе',
        'end','Закрыто']
  end

  def ttms_source_hash
    Hash['client','Клиент',
         'self','Сотрудник']
  end

  def ttms_company_group
    if @staff_login.groupid.include?(10)
                     "DT"
                   else
                     "DD"
                   end
  end

  def ttms_root_list
    ["Авария обрыв оптики",
	"Авария транзита по электропитанию",
	"Авария транзита по железу",
	"Авария с медиком или витой на точке клиента",
	"Проблемы с коммутаторами (Raisecom, D-Link)",
	"Ошибки клиента, запрос доп.инфо",
	"Внешние каналы связи (ВСД, Ретн, ДТ)",
	"Ошибки в настройках/модернизации","Шторм",
	"DHCP","Утилизация кл.порта"]
  end
end
