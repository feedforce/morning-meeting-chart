class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.references :progress, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
