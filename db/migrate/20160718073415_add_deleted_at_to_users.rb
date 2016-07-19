class AddDeletedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :date_time
    add_index :users, :deleted_at
  end
end
