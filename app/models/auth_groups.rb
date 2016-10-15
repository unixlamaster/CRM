class AuthGroups < ActiveRecord::Base
  self.table_name = "user_group"
#  attr_accessible :id, :member, :gid, :permit
  attr_accessible :user, :fisrtname, :surname, :member, :gid, :gr_name

end
