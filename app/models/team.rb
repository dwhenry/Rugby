class Team < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :pool

  default_scope :order => 'name'

  def matches
    Match.all(:conditions => ["home_team_id = :id or away_team_id = :id", {:id => id}])
  end

  def self.team_by_pool
    with_exclusive_scope{all(:order => 'pool, name').group_by(&:pool)}
  end
end
