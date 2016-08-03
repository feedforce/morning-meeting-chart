# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    date Date.new(2016,7,1)
    goal { rand(10) + 15 }
    team
  end
end
