class League < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_many :league_members
  has_many :users, :through => :league_members

  validates_presence_of :name
  validate :confirm_password
  
  def users_by_position
    users.sort(&:points)
  end

  def add_user(user)
    self.league_members.create(:user => user)
  end

  def confirm_password
    if password && changed.include?('password')
      errors.add :password, 'does not match' if password != @password_confirmation
    end
  end

  def position_for(user)
    index = users.index(user) || -1
    while (index > 0 && users[index-1].points == users[index].points)
      index -= 1
    end
    "#{index + 1} (#{users.size})"
  end
end
