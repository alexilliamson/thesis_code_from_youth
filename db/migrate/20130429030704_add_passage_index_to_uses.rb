class AddPassageIndexToUses < ActiveRecord::Migration
  def change
  	add_index :uses, :passage_id
  end
end
