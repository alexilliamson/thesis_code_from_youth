class RemoveColumnFromPhrases < ActiveRecord::Migration
  def up
    remove_column :phrases, :year
  end

  def down
    add_column :phrases, :year, :int
  end
end
