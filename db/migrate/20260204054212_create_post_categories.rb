class CreatePostCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :post_categories do |t|
      t.string :name
      t.string :pattern

      t.timestamps
    end
    add_reference :posts, :post_category, null: false, foreign_key: true
  end
end
