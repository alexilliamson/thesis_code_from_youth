class RemoveIndexFromSpeakers < ActiveRecord::Migration
	def change
		remove_index :speakers, [:year, :party]
	end
end
