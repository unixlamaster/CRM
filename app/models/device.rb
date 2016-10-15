class Device < ActiveRecord::Base
  self.table_name = "device"
  self.inheritance_column = nil
  attr_accessible :id, :delay, :ip, :last_ch, :locat, :mac, :nic, :perc, :uptime, :type
end
