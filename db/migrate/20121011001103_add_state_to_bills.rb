class AddStateToBills < ActiveRecord::Migration
  def up
    add_column :bills, :state, :string

    say_with_time "Updating existing bills" do
      Bill.all.each do |bill|
        bill.state = "complete"
        bill.save
      end
    end
  end

  def down
    remove_column :bills, :state
  end
end
