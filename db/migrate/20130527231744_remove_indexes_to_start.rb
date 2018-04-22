class RemoveIndexesToStart < ActiveRecord::Migration
  def change
  	remove_index :pages, :person_id
  	remove_index :page2s, :person2_id
  end
end
