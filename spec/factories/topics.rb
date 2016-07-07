# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    progress nil
    sequence(:content) { |i| "トピック内容#{i}" }
  end
end
