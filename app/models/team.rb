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

  def self.has_prev_team?(order)
    exists?(['"order" < ?', order])
  end

  def self.has_next_team?(order)
    exists?(['"order" > ?', order])
  end
end
