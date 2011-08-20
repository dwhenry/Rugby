class Team < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :pool

  default_scope :order => 'pool, name'

  def fixtures
    Fixture.all(:conditions => ["home_team_id = :id or away_team_id = :id", {:id => id}])
  end
end
