class AddRejectedByToPost < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :rejected_by, :string
  end
end
