require 'csv'

class Bill < ActiveRecord::Base
  attr_accessible :csv, :csv_cache

  has_many :calls, :dependent => :delete_all
  has_many :invalid_calls, :dependent => :delete_all

  mount_uploader :csv, BillUploader

  def process_csv
    CSV.open(self.csv.current_path, { :headers => :first_row, :header_converters => :symbol } ) do |csv|
      csv.each do |row|
        call = self.calls.build(row.to_hash)
        unless call.save
          invalid = self.invalid_calls.build(row.to_hash)

          invalid.error_messages = call.errors
          invalid.lineno = csv.lineno

          invalid.csv_source = row.to_s
          invalid.save
        end
      end
    end
  end

  validates :csv, :presence => true
end
