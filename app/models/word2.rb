class Word2 < ActiveRecord::Base
  attr_accessible :branch, :stem, :text, :chi2, :chib
  has_and_belongs_to_many :page2s, :autosave => true, :uniq => true
    has_many :person2s, :through => :page2s, :uniq => true
end
