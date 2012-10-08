class Bill < ActiveRecord::Base
  attr_accessible :csv

  has_many :calls

  mount_uploader :csv, BillUploader

  validates :csv, :presence => true
end
