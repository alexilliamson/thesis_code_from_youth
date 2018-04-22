class AddStemBranchIndex < ActiveRecord::Migration
  def change
  	add_index :words, [:stem, :branch]
  end
end
