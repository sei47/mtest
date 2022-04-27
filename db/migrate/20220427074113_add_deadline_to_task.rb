class AddDeadlineToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :date
    change_column_null :tasks, :deadline, null: false
  end
end
