class InstallReport < ActiveRecord::Base
  self.table_name = "install_report"
  attr_accessible :idtask,:cl_id,:cl_name,:t_name,:manager,:flag,:target,:income,:t1s,:t1r,:t2s,:t2r,:t2d,:t3s,:t3r,:t3type,:t3d,:t4s,:t4r,:t4id,:t5s,:t5r,:t5id,:t4date_ch,:t5date_ch

  def self.search(search)
    if search
      where('cl_name LIKE ? OR t_name LIKE ? OR manager LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
