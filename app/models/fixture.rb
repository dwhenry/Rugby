class Fixture < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'

  validates_presence_of :kick_off
  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :description

  def opponent_to(team)
    return home_team unless home_team == team
    away_team
  end
end
