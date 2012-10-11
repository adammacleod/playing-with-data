class FixStringColumnTypes < ActiveRecord::Migration
  def change
    change_column :invalid_calls, :error_messages, :text
  end
end
