class Statistic < ActiveRecord::Base

  attr_accessible :id, :week, :staff_id, :created_at, :updated_at, :otdel, :s1,:s2,:s3,:s4,:s5,:s6,:s7,:s8,:s9,:s10,:s11,:s12

  belongs_to :auth, :foreign_key => 'staff_id'
end
