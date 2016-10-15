class Auth < ActiveRecord::Base
  self.table_name = "virtual_users"
  attr_accessible :born, :domain_id, :firstname, :id, :job, :notice, :password, :quota, :surname, :tel_m, :tel_w1, :tel_w2, :user

  def groupid
    AuthGroups.where(:member=>self.id).pluck(:gid)
  end

  def gr_names
    AuthGroups.where(:member=>self.id).pluck(:gr_name)
  end

  def admin?
    AuthGroups.where(gid: 1).pluck(:member).include?(self.id)
  end

  def fullname
    self.surname << " " << self.firstname
  end
 
  def email
    AuthEmails.where(id: self.id).first.email
  end
end
