# == Schema Information
#
# Table name: progresses
#
#  id         :integer          not null, primary key
#  start_date :date
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  end_date   :date
#  goal_id    :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :progress do
    goal
    amount { rand(5) + 5 }
    sequence(:start_date) { |i| (Date.today - (Date.today.wday - 1) - 7) + i.weeks }
    end_date { start_date + 4.days }
  end
end
