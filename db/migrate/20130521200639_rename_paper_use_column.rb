class RenamePaperUseColumn < ActiveRecord::Migration
  def change
  	rename_column :paper_uses, :phrase_id, :word_id
  end
end
