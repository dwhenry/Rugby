class Player < ActiveRecord::Base
  attr_accessor :password

  belongs_to :user
  belongs_to :league

  validates_presence_of :user_id
  validates_presence_of :league_id
  validate :league_password

  def league_password
    if league.try(:requires_password?)
      errors.add(:base, 'Incorrect password') unless league.password == password
    end
  end
end
