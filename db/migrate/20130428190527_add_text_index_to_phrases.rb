class AddTextIndexToPhrases < ActiveRecord::Migration
  def change
  	add_index :phrases, :text
  end
end
