class CreateSharedInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_infos do |t|
      t.string :title
      t.string :owner
      t.string :body
      t.date :announce_date

      t.timestamps
    end
  end
end
