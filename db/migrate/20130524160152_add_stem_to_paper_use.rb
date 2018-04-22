class AddStemToPaperUse < ActiveRecord::Migration
  def change
  	remove_column :paper_uses, :frequency
  	remove_column :paper_uses, :word_id
    add_column :paper_uses, :stem, :string
  end
end
