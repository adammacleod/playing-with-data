class Call < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :cost, :datetime, :destination, :duration, :source

  # Handling Money:
  # http://stackoverflow.com/questions/1019939/ruby-on-rails-best-method-of-handling-currency-money
  # https://github.com/tobi/money_column
end
