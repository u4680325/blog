class RenameVotersToPendingVoters < ActiveRecord::Migration[8.1]
  def change
    rename_column :posts, :voters, :pending_voters
  end
end
