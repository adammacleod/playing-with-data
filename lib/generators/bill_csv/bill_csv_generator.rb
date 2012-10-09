require 'csv'

class BillCsvGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def write_csv
    #file_name is passed in because this is a Named Generator, it expects a name as the first argument.
    CSV.open("/tmp/test.csv", "wb") do |csv|
      csv << ["Source","Destination","Date","Time","Duration","Cost"]
      generate_csv_row { |row| csv << row }
    end
  end

  private

  def generate_csv_row
    10.times do
      src = source
      rand(500).times do
        yield [src, destination, date, time, duration, cost]
      end
    end
  end

  def source
    "0414%06d" % rand(1000000)
  end

  def destination
    source
  end

  def date
    Time.at(rand(Time.now.to_i)).to_date.strftime("%Y-%m-%d")
  end

  def time
    Time.at(rand(Time.now.to_i)).strftime("%H:%M:%S")
  end

  def duration
    "%02d:%02d:%02d" % [rand(24), rand(60), rand(60)]
  end

  def cost
    "%d.%02d" % [rand(100), rand(100)]
  end
end
