class Call < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :source, :destination, :datetime, :duration, :cost

  # Handling Money:
  # http://stackoverflow.com/questions/1019939/ruby-on-rails-best-method-of-handling-currency-money
  # https://github.com/tobi/money_column

  validates :bill, :presence => true
  validates :source, :presence => true
  validates :destination, :presence => true
  validates :datetime, :presence => true
  validates :duration, :presence => true
  validates :cost, :presence => true
  validates_numericality_of :cost, :greater_than_or_equal_to => 0
  validates_numericality_of :duration, :greater_than_or_equal_to => 0
end
