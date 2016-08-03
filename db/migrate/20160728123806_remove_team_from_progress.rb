class RemoveTeamFromProgress < ActiveRecord::Migration[5.0]
  def change
    remove_reference :progresses, :team, foreign_key: true
  end
end
