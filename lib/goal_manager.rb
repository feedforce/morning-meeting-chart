require 'rails'

class GoalManager
  def self.create_next_week
    Team.include(:goals, :progresses).find_each do |team|
      team.last_date_goal.
    end
  end
end
