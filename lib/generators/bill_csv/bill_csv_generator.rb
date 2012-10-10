require 'csv'

class BillCsvGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  class_option :random_errors, :type => :boolean, :default => false, :description => "Induce random errors"
  class_option :num_accounts, :type => :numeric, :default => 10, :description => "Number of source accounts"
  class_option :max_num_calls, :type => :numeric, :default => 50, :description => "Maximum number of calls per account"

  def write_csv
    CSV.open("doc/#{file_name}.csv", "wb") do |csv|
      csv << ["Source","Destination","Date","Time","Duration","Cost"]
      generate_csv_row { |row| csv << row }
    end
  end

  private

  def generate_csv_row
    options.num_accounts.times do
      src = gen :source
      rand(options.max_num_calls).times do
        yield [src, gen(:destination), gen(:date), gen(:time), gen(:duration), gen(:cost)]
      end
    end
  end

  def gen(method)
    res = self.send(method)
    if options.random_errors and rand > 0.9 # Introduce 10% errors
      res = self.send([:garbage, :reverse, :zero, :negative].sample, res)
    end
    res
  end

  #
  # Error inducing methods
  #
  def garbage(val)
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
    val[rand val.length] = chars[rand chars.length]
  end

  def reverse(val)
    val.reverse
  end

  def zero(val)
    "0"
  end

  def negative(val)
    "-1"
  end

  #
  # Random data generators
  #
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
