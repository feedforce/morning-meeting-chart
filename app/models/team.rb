class Team < ApplicationRecord
  has_many :progresses, dependent: :destroy

  validates :name, presence: true
  validates :goal, presence: true

  enum entity: { orders: 0, sales: 1 }

  def graph(time)
    @graph = GraphCreator.new(self).create(time)
  end

  def goal_formatted
    if self.orders?
      ActionController::Base.helpers.number_to_currency(
        self.goal,
        format: "%n%u",
        unit: ' 件',
        precision: 0
      )
    else
      ActionController::Base.helpers.number_to_currency(
        self.goal,
        format: "%n%u",
        unit: ' 円',
        precision: 0
      )
    end
  end

  def has_current_month_progresses?
    self.progresses.where("start_date like '%-_?-%'", Date.today.month).size > 0 ? true : false
  end
end
