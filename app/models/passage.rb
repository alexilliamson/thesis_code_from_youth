class Passage < ActiveRecord::Base
  attr_accessible :speaker_id, :text, :title
  belongs_to :speaker
  has_many :phrases, :dependent => :destroy
end
