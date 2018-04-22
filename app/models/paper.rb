class Paper < ActiveRecord::Base
  attr_accessible :name, :year, :state
  has_many :paper_uses, :dependent => :delete_all
end
