class CreateProgresses < ActiveRecord::Migration[5.0]
  def change
    create_table :progresses do |t|
      t.integer :amount
      t.date :start_date
      t.integer :team_id
      t.timestamps
    end
  end
end
