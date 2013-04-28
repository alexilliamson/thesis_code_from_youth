class Result < ActiveRecord::Base
  attr_accessible :intercept, :phrase_id, :slope
  belongs_to :phrase
end
