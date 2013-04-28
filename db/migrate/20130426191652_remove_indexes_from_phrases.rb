class RemoveIndexesFromPhrases < ActiveRecord::Migration
  def change
  	remove_index :phrases, [:year,:text]
  end
end
