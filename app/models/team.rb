class Team < ApplicationRecord
  has_many :progresses
  has_many :graphs

  validates :name, presence: true
  validates :goal, presence: true

  def graph
    GraphCreater.new(self).create
  end
end
