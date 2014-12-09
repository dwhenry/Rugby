class League < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_many :players
  has_many :users, through: :players

  validates_presence_of :name
  validate :confirm_password
  default_scope { order('name') }

  def requires_password?
    !password.blank?
  end

  def get_player(user)
    players.detect{ |p| p.user == user}
  end

  def has_member?(user)
    users.include?(user)
  end

  def users_by_position
    users.sort_by(&:points)
  end

  def add_user(user, password)
    players.create(user: user, password: password)
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
