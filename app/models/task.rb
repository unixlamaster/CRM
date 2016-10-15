# -*- encoding : utf-8 -*-
class Task < ActiveRecord::Base
    ActiveRecord::Base.send :include, TasksHelper

  after_create :ins_log
  after_update :upd_log
  after_destroy :del_log
  before_update :set_task_close, :if => :status_changed?

  self.table_name = "task"
  attr_accessible :autor, :cl_id, :dead_line, :zapros_gid, :from_userid, :idtask, :name, :result, :status, :target, :time_change, :time_create, :time_from, :time_to, :to_gid, :to_userid, :type_t, :point_group, :flag, :type_s, :dogovor_num, :dogovor_date, :res1_date, :res2_date, :ppo_income, :dogim, :task_close
  has_many :comments, :foreign_key => "idtask"
  has_many :erpfiles, :foreign_key => "idtask"
  belongs_to :client, :foreign_key => 'cl_id'
  belongs_to :auth, :foreign_key => 'autor'
  belongs_to :from_user, :foreign_key => 'from_userid', class_name: "Auth"
  validates :ppo_income, numericality: true, :if => :type_task_ppomap?
  
  validate :check_client_time_work, :on => :update, message: "Необходимо указывать время работы клиента"
  
  geocoded_by :name
  after_validation :geocode


  def type_task_ppomap?
    type_t =~ /ppomap/
  end

  def self.search(search)
    if search
      where('task.name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  def current_staff=(id)
    @current_staff=id
  end


  protected
   def ins_log
     if self.status == 'end' and self.type_t =~ /pay/
       t = self.dup
       t.type_t = if type_s == 'Телефония'
                     "shem"
                  else
                     self.type_t =~ /wifi/ ? "wifiinstall" : "install"
                  end
       t.time_create = Time.now.getlocal
       t.status = "new"
       t.save
     end
     MngLog.create(cr_time: Time.now.getlocal, who: @current_staff.fullname+" ("+@current_staff.user+")", text: task_action_parser(self.client,self,"create"))
     Mailer.email_addtask(@current_staff,self.client,self).deliver
   end
#===============================================================
   def upd_log
     if self.status == 'end' and self.type_t =~ /pay/ && ! Task.exists?(cl_id: self.cl_id, point_group: self.point_group, zapros_gid: self.zapros_gid, type_t: ["install","wifiinstall"])
       t = self.dup
       t.type_t = if type_s == 'Телефония'
                    "shem"
                  else
                    self.type_t =~ /wifi/ ? "wifiinstall" : "install"
                  end
       t.time_create = Time.now.getlocal
       t.status = "new"
       t.save
     end
   end
   
#===============================================================   
   def set_task_close
     if self.status == 'end'
       self.task_close = Time.now.getlocal 
       self.from_userid = @current_staff.id unless @current_staff.nil?
     end
   end
   def del_log
   end
#===============================================================      
	def check_client_time_work
	
	logger.debug "Check time"
	logger.debug self.type_t
	logger.debug self.client.time_work.inspect
	logger.debug self.client.time_work.length > 9
		if self.type_t == 'zakaz' && self.status!='end2'
			if self.client.time_work.length < 9
				errors.add(:status, "Необходимо указывать время работы клиента")
			end
			if self.client.email.nil? || self.client.email.empty? || self.client.email_tech.nil? || self.client.email_tech.empty? || self.client.contact.nil? || self.client.contact.empty? || self.client.contact_tech.nil?
				errors.add(:status, "Необходимо указывать телефоны и email клиента")
			end
			if self.client.inn.nil? 
				errors.add(:status, "Необходимо указывать ИНН клиента")
			end
		else
			true
		end
	end
end
