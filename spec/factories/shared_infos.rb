# == Schema Information
#
# Table name: shared_infos
#
#  id            :integer          not null, primary key
#  title         :string
#  owner         :string
#  body          :string
#  announce_date :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shared_info do
    sequence(:title) { |i| "共有事項#{i}" }
    sequence(:owner) { |i| "発表者#{i}" }
    sequence(:body) { |i| "共有項目#{i}" }
    sequence(:announce_date) { Date.current }
  end
end
