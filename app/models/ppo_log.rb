class PpoLog < ActiveRecord::Base
  self.table_name = "ppo_log"
  attr_accessible :id,:cl_id,:zapros_id,:point_group,:cl_name,:t_name,:manager,:flag,:target,:income,:type_t,:type_s,:t1cr,:t1ch,:t1s,:t1r,:t2cr,:t2ch,:t2s,:t2r,:t3cr,:t3ch,:t3s,:t3r,:t4cr,:t4ch,:t4s,:t4r,:t4dog_date,:t4dog_num,:t4_i_pay,:t4_e_pay,:t5cr,:t5ch,:t5s,:t5r,:t6cr,:t6ch,:t6s,:t6r,:t7cr,:t7ch,:t7s,:t7r,:t7res1date,:t7res2date,:t8cr,:t8ch,:t8s,:t8r,:t8res1date,:t9cr,:t9ch,:t9s,:t9r,:flag1
  belongs_to :client, :foreign_key => 'cl_id'

  def self.search(search)
    if search
      where('cl_name LIKE ? OR t_name LIKE ? OR manager LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      scoped
    end
  end

end
