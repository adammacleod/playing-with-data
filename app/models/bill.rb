require 'csv'

class Bill < ActiveRecord::Base
  attr_accessible :csv, :csv_cache, :state

  has_many :calls, :dependent => :delete_all
  has_many :invalid_calls, :dependent => :delete_all

  mount_uploader :csv, BillUploader

  state_machine :initial => :new do
    event :run do
      transition :new => :processing
    end

    event :failed do
      transition :processing => :failed
    end

    event :complete do
      transition :processing => :complete
    end
  end

  def process_csv
    self.run

    CSV.open(self.csv.current_path, { :headers => :first_row, :header_converters => :symbol } ) do |csv|
      csv.each do |row|
        call = self.calls.build(row.to_hash)
        unless call.save
          self.calls.delete(call)

          invalid = self.invalid_calls.build(row.to_hash)

          invalid.error_messages = call.errors
          invalid.lineno = csv.lineno

          invalid.csv_source = row.to_s
          invalid.save
        end
      end
    end

    self.invalid_calls.any? ? self.failed : self.complete
  end

  validates :csv, :presence => true
end
