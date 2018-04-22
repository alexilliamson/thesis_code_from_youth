class RemoveJoinIndexes < ActiveRecord::Migration
  def change
  	remove_index :pages_words, [:word_id, :page_id ]
  	remove_index :pages_words, :page_id
  end
end
