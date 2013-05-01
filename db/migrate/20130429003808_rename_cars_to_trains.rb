class RenameCarsToTrains < ActiveRecord::Migration
      def self.up
        rename_table :phrases, :uses
      end
     def self.down
        rename_table :uses, :phrases
     end
end
