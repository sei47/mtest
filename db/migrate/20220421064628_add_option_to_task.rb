class AddOptionToTask < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :name, null: false
    change_column_null :tasks, :content, null: false
  end
end
