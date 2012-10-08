class Bill < ActiveRecord::Base
  attr_accessible :csv

  has_many :calls
end
