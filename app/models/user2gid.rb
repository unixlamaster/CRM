class User2gid < ActiveRecord::Base
  self.table_name = "user_group"
  attr_accessible :gid, :user, :firstname, :surname, :member
end
