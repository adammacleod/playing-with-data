# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call do
    bill nil
    source "0411222333"
    destination "1800555111"
    datetime "2012-10-10 14:34:19"
    duration { '5:10:06'.split(/:/).map { |t| Integer(t) }.reverse.zip([60**0, 60**1, 60**2]).map { |i,j| i*j }.inject(:+) }
    cost "99.55"
  end
end
