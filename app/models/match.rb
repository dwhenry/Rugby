class Match < ActiveRecord::Base
  has_many :sides
  has_one :home_side, -> { where(side: 'home') }, class_name: 'Side'
  has_one :away_side, -> { where(side: 'away') }, class_name: 'Side'
  has_one :home_team, through: 'home_side', source: 'team'
  has_one :away_team, through: 'away_side', source: 'team'
  has_many :teams, -> { order('sides.side DESC') }, through: :sides

  has_many :picks
  has_one :result

  validates_presence_of :kick_off
  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :description
  default_scope { order('match_date, kick_off') }

  def points_for_pick(pick)
    if diff = result.try(:diff)
      if pick == 0 # no pick or picked a draw so 10 point penalty
        diff.abs + 10
      elsif diff == 0 # its a draw so just the points diff
        pick.abs
      elsif pick == diff # dead on so get a bonus
        -10
      elsif (diff / diff.abs) == (pick / pick.abs) # right team so just the points diff
        (diff - pick).abs
      else # wrong team to 5 point penalty
        (diff - pick).abs + 5
      end
    else # no result so no points
      0
    end
  end

  def opponent_to(team)
    teams.where.not(id: team.id).first
  end

  def match
    teams.map(&:short_name).join(' v ').presence || name
  end

  def full_name
    teams.map(&:name).join(' v ').presence || name
  end

  def town
    location.split(',').first
  end

  def pool
    teams.first.try(:pool)
  end

  def match_time
    time = (kick_off - 1).to_s.gsub(/\./,':')
    Time.parse("#{Date.today} #{time}0M")
  end

  def match_finish_time
    match_time.advance(:hours => 3)
  end
end
