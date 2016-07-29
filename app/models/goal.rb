class Goal < ApplicationRecord
  has_many :progresses, dependent: :destroy
  belongs_to :team

  validates :date, presence: true
  validates :goal, presence: true
end
