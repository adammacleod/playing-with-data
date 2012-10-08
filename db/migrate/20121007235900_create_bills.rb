class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :csv

      t.timestamps
    end
  end
end
