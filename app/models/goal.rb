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
  has_many :topics, through: :progresses
  belongs_to :team

  validates :date, presence: true
  validates :goal, presence: true

  def goal_formatted
    if team.orders?
      ActionController::Base.helpers.number_to_currency(
        goal,
        format: "%n%u",
        unit: ' 件',
        precision: 0
      )
    else
      ActionController::Base.helpers.number_to_currency(
        goal,
        format: "%n%u",
        unit: ' 円',
        precision: 0
      )
    end
  end
end
