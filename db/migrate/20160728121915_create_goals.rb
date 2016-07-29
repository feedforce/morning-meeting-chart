class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.date :date
      t.integer :goal
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
