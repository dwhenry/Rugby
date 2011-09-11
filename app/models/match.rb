class Match < ActiveRecord::Base
  belongs_to :home_team, :class_name => 'Team'
  belongs_to :away_team, :class_name => 'Team'
  has_many :picks
  has_one :result

  validates_presence_of :kick_off
  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :description

  def points_for_pick(pick)
    return 0 unless result.try(:diff)
    diff = result.try(:diff)
    return diff.abs + 10 if pick == 0
    return pick.abs if diff == 0
    return -10 if pick == diff
    return (diff - pick).abs if (diff / diff.abs) == (pick / pick.abs)
    (diff - pick).abs + 5
  end

  def opponent_to(team)
    return home_team unless home_team == team
    away_team
  end

  def match
    return "#{home_team.try(:short_name)} v #{away_team.try(:short_name)}" if name == description
    name
  end

  def full_name
    return "#{home_team.try(:name)} v #{away_team.try(:name)}" if name == description
    name
  end

  def town
    location.split(',').first
  end

  def match_time
    time = (kick_off - 1).to_s.gsub(/\./,':')
    Time.parse("#{Date.today} #{time}0M")
  end

  def match_finish_time
    match_time.advance(:hours => 3)
  end
end
