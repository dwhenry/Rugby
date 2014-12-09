class Match < ActiveRecord::Base
  has_many :sides, -> { order(side: :desc) }, autosave: true
  has_many :teams, through: :sides

  has_many :picks

  validates_presence_of :kick_off
  validates_presence_of :location
  validates_presence_of :name
  validates_presence_of :description
  validates :sides, length: { in: (0..2) }

  default_scope { order('match_date, kick_off') }

  def home_team; teams.first; end
  def away_team; teams.last; end

  def points_for_pick(pick)
    if diff
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

  def can_set_score?(user)
    user.admin? &&
      (match_date < Date.today ||
        (match_date == Date.today && Time.now.utc > match_finish_time.utc))
  end

  def diff
    @diff ||= sides.map(&:score_value).compact.inject(:+)
  end

  def details
    return 'Pending' unless sides.all?(&:score)
    winning_side = sides.sort_by(&:score).last
    "#{winning_side.team.try(:short_name)} by #{diff.abs}"
  end
end
