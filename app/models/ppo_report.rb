class PpoReport < ActiveRecord::Base
  self.table_name = "ppo_report"
  attr_accessible :idtask,:cl_id,:cl_name,:t_name,:manager,:flag,:type_t,:target,:type_s,:income,:dogim,:t1cr,:t1ch,:t1s,:t1r,:t2cr,:t2ch,:t2s,:t2r,:t3cr,:t3ch,:t3s,:t3r,:t4cr,:t4ch,:t4s,:t4r,:t4dog_date,:t4dog_num,:t4_i_pay,:t4_e_pay,:t5cr,:t5ch,:t5s,:t5r,:t5cl,:t6cr,:t6ch,:t6r,:t6s,:t7cr,:t7ch,:t7r,:t7s,:t7res1date,:t7res2date,:t8cr,:t8ch,:t8r,:t8s,:t8res1date,:t9cr,:t9ch,:t9r,:t9s,:flag1,:point_group,:zapros_gid

  def self.search(search)
    if search
      where('cl_name LIKE ? OR t_name LIKE ? OR manager LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
