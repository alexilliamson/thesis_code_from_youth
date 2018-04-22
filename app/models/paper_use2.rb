class PaperUse2 < ActiveRecord::Base
  attr_accessible :stem, :paper2_id, :frequency
  belongs_to :paper2
end
