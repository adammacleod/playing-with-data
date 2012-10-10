class Call < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :source, :destination, :date, :time, :duration, :cost

  def duration=(val)
    result = nil
    begin
      result = val.to_s.split(/:/)
             .map { |t| t.to_i }
             .reverse
             .zip([60**0, 60**1, 60**2])
             .map { |i,j| i*j }
             .inject(:+)
    rescue ArgumentError, TypeError
    end
    write_attribute(:duration, result)
  end

  def time=(val)
    result = nil
    begin
      result = Time.parse(val)
    rescue ArgumentError
    end
    write_attribute(:time, result)
  end

  # Handling Money:
  # http://stackoverflow.com/questions/1019939/ruby-on-rails-best-method-of-handling-currency-money
  # https://github.com/tobi/money_column

  validates_presence_of :source
  validates_presence_of :destination
  validates_presence_of :date, :message => "is not a valid date"
  validates_presence_of :time, :message => "is not a valid time"
  validates :duration, :presence => true,
                   :numericality => { :greater_than_or_equal_to => 0 }
  validates :cost, :presence => true,
                   :numericality => { :greater_than_or_equal_to => 0 }
end
