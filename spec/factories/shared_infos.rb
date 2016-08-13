# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shared_info do
    title "MyString"
    owner "MyString"
    body "MyString"
    announce_date "2016-08-13"
  end
end
