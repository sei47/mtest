class AddOptionTitleToTask < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :title, null: false
  end
end
