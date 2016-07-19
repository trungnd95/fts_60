class AddDeletedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :deteled_at, :date_time
    add_index :users, :deleted_at
  end
end
