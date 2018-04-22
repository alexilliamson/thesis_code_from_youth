class PaperUse < ActiveRecord::Base
  attr_accessible :stem, :paper_id, :frequency
  belongs_to :paper
end
