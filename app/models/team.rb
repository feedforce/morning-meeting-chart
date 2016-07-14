class Team < ApplicationRecord
  has_many :progresses

  validates :name, presence: true
  validates :goal, presence: true

  def graph(time)
    @graph = GraphCreater.new(self).create({ year: 2016, month: 7 })
  end

  def goal_formatted
    if self.goal < 1000
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
