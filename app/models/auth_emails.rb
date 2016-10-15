class AuthEmails < ActiveRecord::Base
  self.table_name = "view_users"
  attr_accessible :id, :email, :password, :path, :quota

end
