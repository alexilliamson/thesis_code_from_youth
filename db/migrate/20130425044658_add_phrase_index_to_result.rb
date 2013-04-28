class AddPhraseIndexToResult < ActiveRecord::Migration
  def change
  	add_index :results, :phrase_id
  end
end
