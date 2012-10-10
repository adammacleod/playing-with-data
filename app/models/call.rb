class Call < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :source, :destination, :datetime, :duration, :cost

  def duration=(val)
    begin
      result = val.to_s.split(/:/)
             .map { |t| t.to_i }
             .reverse
             .zip([60**0, 60**1, 60**2])
             .map { |i,j| i*j }
             .inject(:+)
    rescue ArgumentError, TypeError
      errors.add(:duration, "Duration #{val} is not valid.")
    end
    write_attribute(:duration, result)
  end

  # Handling Money:
  # http://stackoverflow.com/questions/1019939/ruby-on-rails-best-method-of-handling-currency-money
  # https://github.com/tobi/money_column

  validates :source, :presence => true
  validates :destination, :presence => true
  validates :datetime, :presence => true
  validates :duration, :presence => true,
                   :numericality => { :greater_than_or_equal_to => 0 }
  validates :cost, :presence => true,
                   :numericality => { :greater_than_or_equal_to => 0 }
end
