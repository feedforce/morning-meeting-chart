# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    progress
    sequence(:content) { |i| "トピックの内容#{i}" }
  end
end
