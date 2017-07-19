class AddDisabledToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :disabled, :boolean, default: false, null: false
  end
end
