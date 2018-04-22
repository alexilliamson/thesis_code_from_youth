class AddParse2index < ActiveRecord::Migration
  def change
  	add_index :word2s, [:stem,:branch]
  	add_index :page2s, :person2_id
  end
end
