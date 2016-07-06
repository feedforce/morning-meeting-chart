class CreateProgresses < ActiveRecord::Migration[5.0]
  def change
    create_table :progresses do |t|
      t.references :team, foreign_key: true
      t.date :start_date
      t.integer :amount

      t.timestamps
    end
  end
end
