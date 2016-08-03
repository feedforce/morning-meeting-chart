class Goal < ApplicationRecord
  has_many :progresses, dependent: :destroy
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
