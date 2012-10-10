class InvalidCall < ActiveRecord::Base
  attr_accessible :cost, :date, :destination, :duration, :error_messages, :references, :source, :time

  serialize :error_messages
end
