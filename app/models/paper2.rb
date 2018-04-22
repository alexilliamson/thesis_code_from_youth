class Paper2 < ActiveRecord::Base
  attr_accessible :name, :state, :year
    has_many :paper_use2s, :dependent => :delete_all
end
