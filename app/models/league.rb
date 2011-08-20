class League < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_many :league_members
  has_many :users, :through => :league_members

  validates_presence_of :name
  validate :confirm_password

  def add_user(user)
    self.league_members.create(:user => user)
  end

  def confirm_password
    if password && changed.include?('password')
      errors.add :password, 'does not match' if password != @password_confirmation
    end
  end
end
