class MngLog < ActiveRecord::Base
  attr_accessible :cr_time, :text, :who

  def self.search(search)
    if search
      where('who LIKE ? OR text LIKE ?', "%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
