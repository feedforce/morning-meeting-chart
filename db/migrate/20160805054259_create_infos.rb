class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :title
      t.string :owner
      t.date :announce_date

      t.timestamps
    end
  end
end
