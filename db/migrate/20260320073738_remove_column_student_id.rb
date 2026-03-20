class RemoveColumnStudentId < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :student_id, :integer, default: 0, null: false
  end
end
