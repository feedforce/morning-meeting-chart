# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name) { |i| "チーム#{i}" }
    sequence(:order) { |i| "#{i}" }
    entity 0
  end
end
