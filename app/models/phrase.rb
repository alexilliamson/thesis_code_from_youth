class Phrase < ActiveRecord::Base
  attr_accessible :chi2, :stem, :year
  has_many :passages, :through => :uses
  has_many :uses
  has_one :result
end
