class CreateInvalidCalls < ActiveRecord::Migration
  def change
    create_table :invalid_calls do |t|
      t.string :source
      t.string :destination
      t.string :date
      t.string :time
      t.string :duration
      t.string :cost
      t.string :error_messages

      t.integer :lineno
      t.string :csv_source

      t.references :bill

      t.timestamps
    end
  end
end
