class ClComment < ActiveRecord::Base
  belongs_to :client
  attr_accessible :notification, :rectype, :text
end
