class RemoveColumnFrom < ActiveRecord::Migration
  def change
  	remove_column :words, :year
  	remove_column :words, :chi2
  end
end
