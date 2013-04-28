class AddColumnToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :passage_id, :int
  end
end
