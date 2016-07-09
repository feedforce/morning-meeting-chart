# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :progress do
    team
    amount { rand(5) + 5 }
    sequence(:start_date) { |i| (Date.today - (Date.today.wday - 1) - 7) + i.weeks }
  end
end
