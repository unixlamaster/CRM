class Port < ActiveRecord::Base
  attr_accessible :cacti_url, :idport, :label, :nic, :port, :status, :time_ch, :trap, :iddev
  belongs_to :device, :foreign_key => 'iddev'
end
