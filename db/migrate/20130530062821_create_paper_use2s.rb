class CreatePaperUse2s < ActiveRecord::Migration
  def change
    create_table :paper_use2s do |t|
      t.string :stem
      t.integer :paper2_id
      t.integer :frequency

      t.timestamps
    end
  end
end
