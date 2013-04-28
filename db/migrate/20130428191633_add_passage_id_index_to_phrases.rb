class AddPassageIdIndexToPhrases < ActiveRecord::Migration
  def change
  	add_index :phrases, :passage_id
  end
end
