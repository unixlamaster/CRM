class TypePhoneNumber < ActiveRecord::Base
  attr_accessible :id, :phone, :type_p

  def self.search(search)
    if search
      where('type_p LIKE ? OR phone LIKE ?', "%#{search}%","%#{search}%")
    else
      scoped
    end
  end
end
