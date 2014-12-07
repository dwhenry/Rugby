class Pick < ActiveRecord::Base
  attr_accessor :error_messages
  belongs_to :match
  belongs_to :user

  validate :valid_pick
  validate :can_be_picked
  validates_presence_of :match_id
  validates_presence_of :user_id
  validates_uniqueness_of :match_id, :scope => :user_id

  def home_team
    return @home_team if @updated
    @home_team ||= (pick && pick > 0 ? pick : nil)
  end

  def away_team
    return @away_team if @updated
    @away_team ||= (pick && pick < 0 ? pick.abs : nil)
  end

  def home_team=(val)
    @updated = true
    @home_team = (val.blank? ? nil : val.to_i)
  end

  def away_team=(val)
    @updated = true
    @away_team = (val.blank? ? nil : val.to_i)
  end

  def can_set?
    (match.match_date > Date.today &&
      match.match_date <= Date.today.advance(:days => 7)) ||

    (match.match_date == Date.today &&
      Time.now.utc < match_time.utc)
  end

  def details
    return results_details if match.try(:result).try(:home_team)
    picks = match.picks.map(&:pick).compact.select{|p| p != 0}
    return '' if picks.empty?
    avg = picks.inject(0.0) {|s, v| s + v} / picks.size
    "#{description_with(pick)} (#{description_with(avg, 1)})"
  end

  def description_with(points, decimals=0)
    return "" if points.blank? || points == 0
    return "#{match.home_team.try(:short_name)} by #{"%.#{decimals}f" % points}" if points > 0
    "#{match.away_team.try(:short_name)} by #{"%.1f" % points.abs}"
  end

  private
  def results_details
    points = match.points_for_pick(pick || 0)
    average = User.all.inject(0.0) do |points, user|
      pick = match.picks.find_by(user_id: user.id).try(:pick) || 0
      points + match.points_for_pick(pick || 0)
    end / User.all.size
    "#{points} / avg #{"%.1f" % average}"
  end

  def valid_pick
    errors.add(:base, 'Pick must be positive') if home_team && home_team < 0
    errors.add(:base, 'Pick must be positive') if away_team && away_team < 0
    errors.add(:base, 'Only enter points for the winning side') if away_team && home_team
    if errors.empty?
      if away_team
        self.pick = -1 * away_team
      elsif home_team
        self.pick = home_team
      else
        self.pick = 0
      end
    end
  end

  def can_be_picked
    errors.add(:base, 'Sorry. It is too late to set a pick for that game.') unless can_set?
  rescue
    puts 'hmm'
  end

  def match_time
    match.match_time
  end
end
