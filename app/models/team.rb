class Team < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :pool

  default_scope { order('name') }

  def matches
    Match.where(["home_team_id = :id or away_team_id = :id", {:id => id}])
  end

  def self.team_by_pool
    Team.order('name').group_by(&:pool)
  end
end
