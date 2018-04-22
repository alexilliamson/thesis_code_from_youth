class Addindex < ActiveRecord::Migration
  def change
  	add_index :pages_words, [:page_id, :word_id]
  	add_index :pages_words, :word_id
  end
end
