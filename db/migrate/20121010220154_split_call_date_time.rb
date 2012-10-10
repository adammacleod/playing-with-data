class SplitCallDateTime < ActiveRecord::Migration
  def up
    add_column :calls, :date, :date
    add_column :calls, :time, :time
    Call.reset_column_information

    Call.all.each do |call|
      call.date = call.datetime.to_date
      call.time = call.datetime.to_time
      call.save
    end

    remove_column :calls, :datetime
  end

  def down
    add_column :calls, :datetime, :datetime
    Call.reset_column_information

    Call.all.each do |call|
      call.datetime = DateTime.parse(%!#{call.date.strftime("%Y-%m-%d")} #{call.time.strftime("%H:%M:%S %Z")}!)
      call.save
    end

    remove_column :calls, :date
    remove_column :calls, :time
  end
end
