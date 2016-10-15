class Ttm < ActiveRecord::Base
  attr_accessible :autor, :cause, :cl_id, :dsc, :idttms, :recap, :source, :status, :time_change, :time_create, :comp_group, :root
  belongs_to :auth, :foreign_key => 'autor'
end
