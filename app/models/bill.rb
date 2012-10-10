require 'csv'

class Bill < ActiveRecord::Base
  attr_accessible :csv, :csv_cache

  has_many :calls, :dependent => :delete_all

  mount_uploader :csv, BillUploader

  before_validation :process_csv, :if => "csv.present?"

  after_validation :save_csv

  def process_csv
    @calls = []
    CSV.open(self.csv.current_path, { :headers => :first_row, :header_converters => :symbol } ) do |csv|
      csv.each do |row|
        @calls << call = Call.new()
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

  def save_csv
    # Unfortunately if I call self.calls.build() inside of process_csv then
    # invalid calls attached to the bill will cause extra errors.
    # To avoid this I don't attach calls until I know they are all valid.
    @calls.each do |call|
      self.calls << call
    end if @calls
  end

  validates :csv, :presence => true
end
