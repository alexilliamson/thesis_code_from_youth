class Branchindex < ActiveRecord::Migration
  def change
  	add_index :words, :branch
  end
end
