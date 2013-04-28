class AddColumnToResults < ActiveRecord::Migration
  def change
    add_column :results, :slope2, :float
  end
end
