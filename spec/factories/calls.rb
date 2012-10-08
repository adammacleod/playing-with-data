# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call do
    bill nil
    source "MyString"
    destination "MyString"
    datetime "2012-10-08 11:13:48"
    duration 1
    cost "9.99"
  end
end
