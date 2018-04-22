class CreatePage2sWord2sJoinTable < ActiveRecord::Migration
  def change
  	create_table :page2s_word2s, :id => false do |t|
	  t.integer :page2_id
	  t.integer :word2_id
	end
  end
end
