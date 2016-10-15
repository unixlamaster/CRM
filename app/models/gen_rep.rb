class GenRep < ActiveRecord::Base
  self.table_name = "genrep"
  attr_accessible :cl_id, :name, :address, :mng, :flag, :speed, :d1, :d2, :result, :type_t, :status, :type_s, :task_close, :tflag
  belongs_to :client, :foreign_key => 'cl_id'
  belongs_to :task, :foreign_key => 'idtask'

  def self.search(search)
    if search
      where('name LIKE ? OR address LIKE ? OR mng LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
