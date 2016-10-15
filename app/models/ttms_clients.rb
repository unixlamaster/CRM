class TtmsClients < ActiveRecord::Base
  attr_accessible :cause, :cl_id, :dsc, :idttms, :recap, :source, :status, :time_change, :time_create, :name, :address, :period, :comp_group, :autor
  set_primary_key :idttms
 belongs_to :auth, :foreign_key => 'autor'

  def self.search(search)
    if search
      where('name LIKE ? OR cause LIKE ? OR dsc LIKE ? OR recap LIKE ? OR source LIKE ? OR address LIKE ? OR idttms=?', "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%",search)
    else
      scoped
    end
  end

end
