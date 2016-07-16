class AddDeletedAtToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :deleted_at, :date_time
    add_index :subjects, :deleted_at
  end
end
