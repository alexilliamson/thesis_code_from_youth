class CreatePaper2s < ActiveRecord::Migration
  def change
    create_table :paper2s do |t|
      t.string :name
      t.integer :year
      t.string :state

      t.timestamps
    end
  end
end
