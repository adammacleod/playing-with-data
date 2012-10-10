require 'csv'

class Bill < ActiveRecord::Base
  attr_accessible :csv, :csv_cache

  has_many :calls, :dependent => :delete_all
  has_many :invalid_calls, :dependent => :delete_all

  mount_uploader :csv, BillUploader

  def process_csv
    CSV.open(self.csv.current_path, { :headers => :first_row, :header_converters => :symbol } ) do |csv|
      csv.each do |row|
        call = Call.new()
        call.source = row[:source]
        call.destination = row[:destination]
        call.date = row[:date]
        call.time = row[:time]
        call.duration = row[:duration]
        call.cost = row[:cost]
        call.bill = self
        unless call.save
          ic = self.invalid_calls.build()
          ic.source = row[:source]
          ic.destination = row[:destination]
          ic.date = row[:date]
          ic.time = row[:time]
          ic.duration = row[:duration]
          ic.cost = row[:cost]

          ic.error_messages = call.errors
          ic.lineno = csv.lineno

          ic.csv_source = row.to_s
          ic.save
        end
      end
    end
  end

  validates :csv, :presence => true
end
