class AddEndDateToProgress < ActiveRecord::Migration[5.0]
  def change
    add_column :progresses, :end_date, :date
  end
end
