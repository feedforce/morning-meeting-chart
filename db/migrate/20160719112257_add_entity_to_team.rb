class AddEntityToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :entity, :integer
  end
end
