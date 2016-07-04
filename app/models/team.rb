class Team < ApplicationRecord
  has_many :progresses

  validates :name, presence: true
  validates :goal, presence: true
end
