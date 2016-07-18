class AddTimeToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :start_time, :integer
    add_column :examinations, :end_time, :integer
  end
end
