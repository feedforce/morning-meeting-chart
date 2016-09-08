# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  progress_id :integer
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    progress
    sequence(:content) { |i| "トピック内容#{i}" }
  end
end
