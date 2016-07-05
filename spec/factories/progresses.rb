# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :progress do
    team nil
    start_date "2016-07-05"
    amount 1
  end
end
