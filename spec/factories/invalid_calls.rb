# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invalid_call do
    source "MyString"
    destination "MyString"
    date "MyString"
    time "MyString"
    duration "MyString"
    cost "MyString"
    errors "MyString"
    references ""
  end
end
