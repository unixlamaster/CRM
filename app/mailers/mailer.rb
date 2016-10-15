# -*- encoding : utf-8 -*-
class Mailer < ActionMailer::Base
  include TasksHelper
  include TtmsHelper
  default from: "crm@di-di.ru"
 
  def type_t_email (task,client)
    if Rails.env.production?
		to = case(task.type_t)
		when /^wifi/
			"wifi@ditelia.ru, crm@di-di.ru"
		else
			if task.type_t == "install1" && task.status == "end"
				"noc@di-di.ru"
			elsif client.flag=='DD'
			"crmlist@di-di.ru"
			else
			"crm@di-di.ru"
			end
		end
		to += ", g.morgun@di-di.ru" if task.type_t == 'ppomap' && task.type_s == 'Аренда ВОК'
		to += ", wifi@ditelia.ru" if client.name=~/^Диалог-Телеком/
		to
	else
	  "m.klimenko@di-di.ru"
	end
  end

  def email_addtask(staff_login,client,task)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = type_t_email(task,client)
    @task = task
    @client = client
	subj = task.type_t == 'zakaz' && task.status == 'end1' ? "Расторжение договора" : "#{task_type_hash[@task.type_t]}"
	subj += ", #{@task.name}, #{@client.name} от #{staff_login.fullname}"
    mail(from: @staff_from, to: @staff_to, subject: subj)
  end

  def email_task_mesg(staff_login,client,task,comments)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = type_t_email(task,client)
    @task = task
    @client = client
    @comments = comments
    mail(from: @staff_from, to: @staff_to, subject: "Re: #{task_type_hash[@task.type_t]}, #{@task.name}, #{@client.name} от #{staff_login.fullname}")
  end

  def email_task_status(staff_login,client,task,comments,erpfiles)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = type_t_email(task,client)
    @task = task
    @client = client
    @comments = comments
    @erpfiles = erpfiles
    mail(from: @staff_from, to: @staff_to, subject: "Результат #{task_type_hash[@task.type_t]}, #{@task.name}, #{@client.name} от #{staff_login.fullname}")
  end

  def email_task_change_status(staff_login,client,task,comments,erpfiles)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = type_t_email(task,client)
    @task = task
    @client = client
    @comments = comments
    @erpfiles = erpfiles
    mail(from: @staff_from, to: @staff_to, subject: "Изменен статус задачи #{task_type_hash[@task.type_t]}, #{@task.name}, #{@client.name} от #{staff_login.fullname}") 
  end

  def email_task_end(staff_login,client,task,pp)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = type_t_email(task,client)
    @task = task
    @client = client
    @ppolog = pp
    @comments = task.comments
    mail(from: @staff_from, to: @staff_to, subject: "Результат #{task_type_hash[@task.type_t]}, #{@task.name}, #{@client.name} от #{staff_login.fullname}")
  end

  def email_task_end1(staff_login,client,task)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = "noc@di-di.ru"
    @task = task
    @client = client
    mail(from: @staff_from, to: @staff_to, subject: "Расторжение #{task_type_hash[@task.type_t]}, #{@task.name}, #{@client.name} от #{staff_login.fullname}")
  end

  def email_task_shem(staff_login,client,task,comments,erpfiles)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = type_t_email(task,client)
    @task = task
    @client = client
    @comments = comments
    @erpfiles = erpfiles
    mail(from: @staff_from, to: @staff_to, subject: "Топология #{task_type_hash[@task.type_t]}, #{@task.name}, #{@client.name} от #{staff_login.fullname}")
  end

#==============================================================================
  def email_ttms(ttm)
    @staff_from = "tt@di-di.ru"
    @staff_to = "tt@di-di.ru"
    @ttm = ttm
    @source = ttms_source_hash[ttm.source]
    @status = ttms_status_hash[ttm.status]
    @client = Client.find(ttm.cl_id)
    mail(from: @staff_from, to: @staff_to, subject: "ТT, #{@client.name}")
  end

  def email_new_client(staff_login,client)
    @staff_from = staff_login.groupid.include?(6) ? "crm@di-di.ru" : staff_login.email
    @staff_to = client.flag=='DD' ? "crm_new_dd@di-di.ru" : "crm_new_dt@di-di.ru"
    @client = client
    mail(from: @staff_from, to: @staff_to, subject: "Добавлен новый клиент #{@client.name} от #{staff_login.fullname}")
  end
  
  def client_notification(emails)
    attachments.inline['di-di.png'] = File.read('public/images/di-di.png')
    mail(from: "b2b@di-di.ru", to: emails, subject: "Напоминаие о задолженности за услуги связи")
  end
  
	def generate_spam(emails)
		attachments.inline['support.jpg'] = File.read('public/images/support.jpg')
		attachments.inline['di-di.png'] = File.read('public/images/di-di.png')
		mail(from: "support@di-di.ru", to: "support@di-di.ru", bcc: emails, subject: "Появились ещё три способа связи с технической поддержкой \"Цифровой Диалог\"")
	end
	
	def generate_spam2(emails)
		attachments.inline['support2.jpg'] = File.read('public/images/support2.jpg')
		attachments.inline['Инструкция.pdf'] = File.read('public/images/Инструкция.pdf')
		attachments.inline['di-di.png'] = File.read('public/images/di-di.png')
		mail(from: "support@di-di.ru", to: "support@di-di.ru", bcc: emails, subject: "Изменения в сетевых настройках подключения к сети \"Цифровой Диалог\"")
	end
end
