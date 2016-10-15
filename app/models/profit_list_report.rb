class ProfitListReport < ActiveRecord::Base
  self.table_name = "profitlist_report"
  attr_accessible :cl_id,:name,:pay,:speed,:flag,:dogovor_date,:dogovor_num

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
