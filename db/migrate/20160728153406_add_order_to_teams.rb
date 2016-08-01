class AddOrderToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :order, :integer, unique: true
  end
end
