class CactiHost < ActiveRecord::Base
  establish_connection "cacti_db"
  self.table_name = "host"
  attr_accessible :id, :description, :hostname
  has_many :cacti_graph, :foreign_key => "host_id"
end
