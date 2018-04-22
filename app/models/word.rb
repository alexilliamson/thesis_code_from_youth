class Word < ActiveRecord::Base
  attr_accessible :stem, :text, :year, :branch, :chi2, :chib
  has_and_belongs_to_many :pages, :autosave => true, :uniq => true
  has_many :people, :through => :pages, :uniq => true
end
