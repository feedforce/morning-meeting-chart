class Team < ApplicationRecord
  has_many :goals, dependent: :destroy

  validates :name, presence: true
  validates :order, presence: true, uniqueness: true

  enum entity: { orders: 0, sales: 1 }

  scope :prev_team, -> (order) { where('"order" < ?', order).order(:order).last }
  scope :next_team, -> (order) { where('"order" > ?', order).order(:order).first }

  def graph(time)
    @graph = GraphCreator.new(self).create(time)
  end

  def goal_formatted
    if orders?
      ActionController::Base.helpers.number_to_currency(
        goals.last.goal,
        format: "%n%u",
        unit: ' 件',
        precision: 0
      )
    else
      ActionController::Base.helpers.number_to_currency(
        goals.last.goal,
        format: "%n%u",
        unit: ' 円',
        precision: 0
      )
    end
  end

  def self.has_prev_team?(order)
    exists?(['"order" < ?', order])
  end

  def self.has_next_team?(order)
    exists?(['"order" > ?', order])
  end
end
