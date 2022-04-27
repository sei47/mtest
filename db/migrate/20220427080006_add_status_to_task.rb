class AddStatusToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :string
    change_column_null :tasks, :status, null: false
  end
end
