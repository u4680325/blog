class AddReferenceUserToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
    add_column :users, :name, :string
  end
end
