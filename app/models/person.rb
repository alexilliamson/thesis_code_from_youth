class Person < ActiveRecord::Base
  attr_accessible :branch, :name, :party, :score1, :score2, :year
  has_many :pages, :dependent => :delete_all, :uniq => true, :autosave => :true
  scope :lefth, where('score1 <= ? and branch = ?', Person.where(:branch => 'H').pluck(:score1).sort[190], 'H')
  scope :middleh, where('score1 > ? and score1 <= ? and branch = ?', Person.where(:branch => 'H').pluck(:score1).sort[190], Person.where(:branch => 'H').pluck(:score1).sort[254], 'H')
  scope :righth, where('score1 > ? and branch = ?', Person.where(:branch => 'H').pluck(:score1).sort[254], 'H')
  scope :lefts, where('score1 <= ? and branch = ?', Person.where(:branch => 'S').pluck(:score1).sort[43], 'S')
  scope :middles, where('score1 > ? and score1 <= ? and branch = ?', Person.where(:branch => 'S').pluck(:score1).sort[43], Person.where(:branch => 'S').pluck(:score1).sort[57], 'S')
  scope :rights, where('score1 > ? and branch = ?', Person.where(:branch => 'S').pluck(:score1).sort[57], 'S')
  scope :lefthb, where('score2 <= ? and branch = ?', Person.where(:branch => 'H').pluck(:score2).sort[190], 'H')
  scope :middlehb, where('score2 > ? and score2 <= ? and branch = ?', Person.where(:branch => 'H').pluck(:score2).sort[190], Person.where(:branch => 'H').pluck(:score2).sort[254], 'H')
  scope :righthb, where('score2 > ? and branch = ?', Person.where(:branch => 'H').pluck(:score2).sort[254], 'H')
  scope :leftsb, where('score2 <= ? and branch = ?', Person.where(:branch => 'S').pluck(:score2).sort[43], 'S')
  scope :middlesb, where('score2> ? and score2 <= ? and branch = ?', Person.where(:branch => 'S').pluck(:score2).sort[43], Person.where(:branch => 'S').pluck(:score2).sort[57], 'S')
  scope :rightsb, where('score2 > ? and branch = ?', Person.where(:branch => 'S').pluck(:score2).sort[57], 'S')
end
