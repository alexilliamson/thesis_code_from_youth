class AddPhraseIndexToUses < ActiveRecord::Migration
  def change
  	add_index :uses, :phrase_id
  end
end
