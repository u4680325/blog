class RenamePermitsToPendingApprovers < ActiveRecord::Migration[8.1]
  def change
    rename_column :posts, :permits, :pending_approvers
  end
end
