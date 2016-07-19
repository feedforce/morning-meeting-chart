class AddEntityToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :entity, :integer, default: 0
  end
end
