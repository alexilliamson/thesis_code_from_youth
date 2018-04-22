class AddChibColumnToWords < ActiveRecord::Migration
  def change
    add_column :words, :chib, :float
    add_column :word2s, :chib, :float
  end
end
