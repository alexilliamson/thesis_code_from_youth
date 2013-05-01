class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :stem
      t.float :chi2
      t.integer :year

      t.timestamps
    end
  end
end
