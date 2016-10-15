class ClientPost < ActiveRecord::Base
  attr_accessible :body, :cl_id, :remind, :staff_id
  belongs_to :client, :foreign_key => 'cl_id'
  belongs_to :auth, :foreign_key => 'staff_id'

  def self.search(search)
    if search
      where('body LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
