class AddIdToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :staff_id, :integer, default: 0, null: false
    add_column :users, :student_id, :integer, default: 0, null: false
    add_column :users, :role_id, :integer, default: 0, null: false
  end
end
