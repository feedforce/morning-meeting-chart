class Goal < ApplicationRecord
  belongs_to :team

  validates :date, presence: true
  validates :goal, presence: true
end
