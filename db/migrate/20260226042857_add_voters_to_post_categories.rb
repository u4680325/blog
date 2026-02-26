class AddVotersToPostCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :voters, :text
    add_column :post_categories, :voters, :text
  end
end
