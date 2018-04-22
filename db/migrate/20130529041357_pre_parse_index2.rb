class PreParseIndex2 < ActiveRecord::Migration
  def up
  	add_index :page2s, :person2_id
  end
end
