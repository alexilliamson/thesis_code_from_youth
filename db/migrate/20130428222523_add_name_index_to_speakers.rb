class AddNameIndexToSpeakers < ActiveRecord::Migration
  def change
  	add_index :speakers, :year
  	add_index :speakers, :party
  end
end
