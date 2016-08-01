# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name) { |i| "チーム#{i}" }
    sequence(:order) { |i| "#{i}" }
    goal { rand(10) + 15 }
  end
end
