# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    team
    date Date.current
    goal { rand(10) + 15 }
  end
end
