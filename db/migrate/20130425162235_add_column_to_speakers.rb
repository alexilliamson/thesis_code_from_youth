class AddColumnToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :score2, :float
  end
end
