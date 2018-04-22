class Change < ActiveRecord::Migration
  def change
  	remove_index :pages_words, [:page_id, :word_id]
  	remove_index :pages_words, :word_id
  	add_index :pages_words, [:word_id, :page_id]
  	add_index :pages_words, :page_id
  end
end
