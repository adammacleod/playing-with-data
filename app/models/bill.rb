require 'csv'

class Bill < ActiveRecord::Base
  attr_accessible :csv, :csv_cache

  has_many :calls, :dependent => :delete_all

  mount_uploader :csv, BillUploader

  before_create :process_csv

  def process_csv
    CSV.foreach(self.csv.current_path, { :headers => :first_row, :header_converters => :symbol } ) do |row|
      logger.debug row.inspect
      logger.debug row[:source].inspect
      call = self.calls.build()
      call.source = row[:source]
      call.destination = row[:source]
      call.datetime = "#{row[:date]} #{row[:time]}"
      call.duration = row[:duration]
      call.cost = row[:cost]
      call.save
    end
  end

  validates :csv, :presence => true
end
