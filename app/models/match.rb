class Match < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'
  has_many :picks

  validates_presence_of :kick_off
  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :description

  def opponent_to(team)
    return home_team unless home_team == team
    away_team
  end

  def match
    return "#{home_team.try(:short_name)} v #{away_team.try(:short_name)}" if name == description
    name
  end

  def town
    location.split(',').first
  end
end
