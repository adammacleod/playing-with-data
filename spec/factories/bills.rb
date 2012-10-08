# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bill do
    csv { File.open(File.join(Rails.root, 'doc', 'sample.csv')) }
  end
end
