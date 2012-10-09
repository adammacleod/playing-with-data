require 'csv'

class Bill < ActiveRecord::Base
  attr_accessible :csv, :csv_cache

  has_many :calls, :dependent => :delete_all

  mount_uploader :csv, BillUploader

  before_validation :process_csv, :if => "csv.present?"

  def process_csv
    CSV.open(self.csv.current_path, { :headers => :first_row, :header_converters => :symbol } ) do |csv|
      csv.each do |row|
        # csv.lineno
        call = self.calls.build()
        call.source = row[:source]
        call.destination = row[:source]
        call.datetime = "#{row[:date]} #{row[:time]}"
        call.duration = row[:duration]
        call.cost = row[:cost]
        unless call.valid?
          call.errors.each do |attr, message|
            errors.add(:csv, "Line #{csv.lineno}, #{attr} #{message}")
          end
        end
      end
    end
  end

  validates :csv, :presence => true
end
