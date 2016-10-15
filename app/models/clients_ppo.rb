# -*- encoding : utf-8 -*-
class ClientsPpo < ActiveRecord::Base
  self.table_name = "clients_ppo"
  attr_accessible :cl_id, :name, :address, :manager, :dogovor_num

  def self.search(search)
    if search
      where('name LIKE ? OR address LIKE ? OR manager LIKE ? OR dogovor_num LIKE ?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
