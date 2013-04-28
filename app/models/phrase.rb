class Phrase < ActiveRecord::Base
  attr_accessible :text, :year, :chi2, :passage_id
  belongs_to :passage
  has_one :result
end
