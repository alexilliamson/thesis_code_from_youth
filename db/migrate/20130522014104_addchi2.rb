class Addchi2 < ActiveRecord::Migration
  def change
  	add_column :words, :chi2, :float
  end
end
