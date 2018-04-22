class AddScoreIndexes < ActiveRecord::Migration
  def change
  	add_index :people, :score1
  end
end
