class CreateGraphs < ActiveRecord::Migration[5.0]
  def change
    create_table :graphs do |t|
      t.references :team, foreign_key: true
      t.string :yaxis

      t.timestamps
    end
  end
end
