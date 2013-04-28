class Speaker < ActiveRecord::Base
  attr_accessible :name, :year, :congress, :party, :score, :branch, :score2
  has_many :passages, :dependent => :destroy
  has_many :occurences
end
