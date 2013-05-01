class AddIndexToPhrases < ActiveRecord::Migration
  def change
  	add_index :phrases, [:stem,:year]
  end
end
