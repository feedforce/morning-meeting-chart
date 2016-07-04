# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :progress do
    team
    amount { rand(6) + 3 }
    sequence(:start_date) { |i| Time.current + (i - 1).weeks }
  end
end
