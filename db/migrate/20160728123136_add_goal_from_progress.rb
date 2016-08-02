class AddGoalFromProgress < ActiveRecord::Migration[5.0]
  def change
    add_reference :progresses, :goal, foreign_key: true
  end
end
