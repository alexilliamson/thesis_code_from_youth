class RevertPaperUse < ActiveRecord::Migration
  def change
  	add_column :paper_uses, :frequency, :integer
  end
end
