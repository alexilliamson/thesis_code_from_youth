class PreScore2 < ActiveRecord::Migration
  def change
  	add_index :word2s, :branch
  	add_column :word2s, :chi2, :float 
  	add_index :page2s_word2s, [:word2_id, :page2_id]
  	add_index :page2s_word2s, :page2_id
  end
end
