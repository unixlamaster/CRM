class ClientPortService < ActiveRecord::Base
#  self.table_name = "client_port_services"
  attr_accessible :serv_id, :name, :type_s, :city, :addr, :speed, :vlan, :ipaddr,:cl_port, :status, :cacti_url, :cl_id, :port_id, :device_ip, :device_port
  belongs_to :port
  has_many :tasks, :foreign_key => :cl_id
  set_primary_key(:serv_id)
  
  def self.search(search)
    if search
		if search =~/^\d+$/
			where('name LIKE ? OR city LIKE ? OR ipaddr LIKE ? OR cl_port LIKE ? OR vlan=? OR type_s LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%",search.to_i,"%#{search}%")
		else
			where('name LIKE ? OR city LIKE ? OR ipaddr LIKE ? OR cl_port LIKE ? OR type_s LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%")
		end
    else
      scoped
    end
  end

end
