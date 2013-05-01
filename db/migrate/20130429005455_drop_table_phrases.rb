class DropTablePhrases < ActiveRecord::Migration
	def change
		drop_table :uses
	end
end
