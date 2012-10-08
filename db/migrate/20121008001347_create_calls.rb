class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.references :bill
      t.string :source
      t.string :destination
      t.datetime :datetime
      t.integer :duration
      t.decimal :cost, :precision => 10, :scale => 2, :default => 0.0

      t.timestamps
    end
    add_index :calls, :bill_id
  end
end
