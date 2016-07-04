# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name) { |i| "name#{i}" }
    goal  { rand(15) + 10 }
  end
end
