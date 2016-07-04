class Team < ApplicationRecord
  has_many :progresses

  validates :name, present: true
  validates :goal, present: true
end
