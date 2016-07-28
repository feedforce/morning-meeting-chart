class Team < ApplicationRecord
  validates :name, presence: true

  enum entity: { orders: 0, sales: 1 }

  def graph(time)
    @graph = GraphCreater.new(self).create(time)
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
end
