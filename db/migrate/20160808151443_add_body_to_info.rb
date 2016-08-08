class AddBodyToInfo < ActiveRecord::Migration[5.0]
  def change
    add_column :infos, :body, :string
  end
end
