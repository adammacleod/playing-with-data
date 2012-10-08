class Call < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :cost, :datetime, :destination, :duration, :source
end
