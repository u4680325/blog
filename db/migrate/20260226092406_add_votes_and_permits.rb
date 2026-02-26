class AddVotesAndPermits < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :permits, :text
    add_column :posts, :votes, :text
  end
end
