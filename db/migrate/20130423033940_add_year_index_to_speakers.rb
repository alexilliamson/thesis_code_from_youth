class AddYearIndexToSpeakers < ActiveRecord::Migration
  def change
  	add_index :speakers, [:year, :party]
  end
end
