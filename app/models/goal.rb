# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  date       :date
#  goal       :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Goal < ApplicationRecord
  has_many :progresses, dependent: :destroy
  belongs_to :team

  validates :date, presence: true
  validates :goal, presence: true
  validates :goal, numericality:
                      {
                        only_integer: true, greater_than_or_equal_to: 1
                      }


  def goal_formatted
    ActionController::Base.helpers.number_to_currency(goal, format_options)
  end

  private

  def format_options
    if team.orders?
      { format: '%n%u', unit: ' 件', precision: 0 }
    else
      { format: '%n%u', unit: ' 円', precision: 0 }
    end
  end
end
