class PreScoreIndexes < ActiveRecord::Migration
  def up
  	add_index :pages_words, [:word_id,:page_id]
  	add_index :pages_words, :page_id
  	add_index :words, :branch
  	add_column :words, :chi2, :float
  end
end
