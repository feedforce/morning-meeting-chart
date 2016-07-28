class RemoveGoalFromTeam < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :goal, :integer
  end
end
