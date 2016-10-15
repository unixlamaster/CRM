class CactiGraph < ActiveRecord::Base
  establish_connection "cacti_db"
  self.table_name = "graph_local"
  attr_accessible :id, :host_id, :snmp_index
  belongs_to :cacti_host, :foreign_key => 'host_id'
end
