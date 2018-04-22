class Page < ActiveRecord::Base
  attr_accessible :person_id, :text, :title
  belongs_to :person, :autosave => :true
  has_and_belongs_to_many :words,  :uniq => true
end
