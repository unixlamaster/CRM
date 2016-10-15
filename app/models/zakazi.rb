class Zakazi < ActiveRecord::Base
  self.table_name = "zakazi"
  attr_accessible :cl_id, :fname, :idzakaz, :service_t, :status, :type_pril, :zdate, :znum
end
