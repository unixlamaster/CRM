class Gid2name < ActiveRecord::Base
  self.table_name = "gid2name"
  attr_accessible :id, :name

end
