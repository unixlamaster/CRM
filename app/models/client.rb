# -*- encoding : utf-8 -*-
class Client < ActiveRecord::Base
  attr_accessible :address, :city, :cl_src, :contact, :date_add, :flag, :flag2, :email, :income, :manager, :name, :payment, :date_pay, :remark, :time_work, :connect_type, :registr_addr, :date_close,
					:inn, :notificate_phone, :notificate_date, :notificate_result,
					:email_tech, :contact_tech, :notificate_sms
  has_many :tasks, :foreign_key => :cl_id
  has_many :ppo_reports, :foreign_key => :cl_id
  validates_uniqueness_of :name
  validates :cl_src, presence: true
#  validates :time_work, length: { minimum: 9, message: "Необходимо указывать время работы" }
	validates :name, format: { without: /[a-zA-Z]+/, message: "Название клиента только на кириллице" }
	validates :notificate_phone, format: { with: /^8\d{10,10}$|^$/, message: "Номер в формате 8xxxxxxxxxx" }
	validates :notificate_sms, format: { with: /^8\d{10,10}$|^$/, message: "Номер в формате 8xxxxxxxxxx" }

  def self.search(search)
    if search
      where('clients.name LIKE ? OR clients.address LIKE ? OR clients.city LIKE ? OR clients.manager LIKE ? OR clients.registr_addr LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
