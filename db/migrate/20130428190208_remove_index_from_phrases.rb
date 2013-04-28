class RemoveIndexFromPhrases < ActiveRecord::Migration
  def change
  	remove_index :phrases, [:passage_id, :text]
  end
end
