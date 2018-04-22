class AddColumnToWords < ActiveRecord::Migration
  def change
    add_column :words, :chi2, :float
  end
end
