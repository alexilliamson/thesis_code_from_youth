class Page2 < ActiveRecord::Base
  attr_accessible :text, :title
  belongs_to :person2
  has_and_belongs_to_many :word2s, :autosave => true, :uniq => true
end
