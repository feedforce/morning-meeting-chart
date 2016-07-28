# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    date "2016-07-28"
    goal 1
    team nil
  end
end
