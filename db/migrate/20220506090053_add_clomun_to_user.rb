class AddClomunToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin_flag, :boolean
  end
end
