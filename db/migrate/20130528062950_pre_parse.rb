class PreParse < ActiveRecord::Migration
  def up
  	add_index :pages, [:person_id]
  	remove_column :words, :chi2
  	remove_index :words, :branch
  	remove_index :pages_words, [:word_id, :page_id]
  	remove_index :pages_words, :page_id

  end
end
