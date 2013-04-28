class RemoveDetailsFromOccurences < ActiveRecord::Migration
  def up
    remove_column :occurences, :counter
  end

  def down
    add_column :occurences, :counter, :integer
  end
end
