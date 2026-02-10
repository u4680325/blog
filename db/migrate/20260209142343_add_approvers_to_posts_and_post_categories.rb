class AddApproversToPostsAndPostCategories < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :approvers, :text
    add_column :post_categories, :approvers, :text
  end
end
