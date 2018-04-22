class AddColumnToPerson2s < ActiveRecord::Migration
  def change
    add_column :person2s, :year, :integer
  end
end
