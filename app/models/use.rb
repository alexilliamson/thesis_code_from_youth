class Use < ActiveRecord::Base
  attr_accessible :passage_id, :phrase_id, :text
  belongs_to :passage
  belongs_to :phrase
end
