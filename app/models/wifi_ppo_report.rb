class WifiPpoReport < ActiveRecord::Base
  self.table_name = "wifi_ppo_report"
  attr_accessible :idtask,:cl_id,:cl_name,:t_name,:manager,:flag,:target,:type_s,:t1cr,:t1ch,:t1s,:t1r,:t2cr,:t2ch,:t2s,:t2r,:t3cr,:t3ch,:t3s,:t3r,:t4cr,:t4ch,:t4s,:t4r,:t4dog_date,:t4dog_num,:t4_i_pay,:t4_e_pay,:t5cr,:t5ch,:t5s,:t5r

  def self.search(search)
    if search
      where('cl_name LIKE ? OR t_name LIKE ? OR manager LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
