# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call do
    association :bill, factory: :bill
    source "0411222333"
    destination "1800555111"
    datetime "2012-10-10 14:34:19"
    duration '5:10:06'
    cost "99.55"
  end
end
