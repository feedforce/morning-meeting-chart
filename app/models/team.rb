# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  entity     :integer          default("orders")
#  order      :integer
#

class Team < ApplicationRecord
  has_many :goals, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :order, presence: true, uniqueness: true
  validates :order, numericality:
                      {
                        only_integer: true, greater_than_or_equal_to: 1
                      }

  validates :entity, presence: true
  enum entity: { orders: 0, sales: 1 }

  scope :enabled, -> () { where(disabled: false) }

  def self.prev_team(order)
    enabled.where('"order" < ?', order).order(:order).last
  end

  def self.next_team(order)
    enabled.where('"order" > ?', order).order(:order).first
  end

  def self.has_prev_team?(order)
    prev_team(order).present?
  end

  def self.has_next_team?(order)
    next_team(order).present?
  end

  def current_month_goal?
    goals.order(:date).last.date.month == last_monday.month if goals
  end

  private

  def last_monday
    this_day = Date.today
    this_day - (this_day.wday - 1)
  end
end
