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
    @home_team ||= (pick && pick > 0 ? pick : nil)
  end

  def away_team
    @away_team ||= (pick && pick < 0 ? pick.abs : nil)
  end

  def home_team=(val)
    @home_team = (val.blank? ? nil : val.to_i)
  end

  def away_team=(val)
    @away_team = (val.blank? ? nil : val.to_i)
  end

  def can_set?
    (match.match_date > Date.today &&
      match.match_date <= Date.today.advance(:days => 7)) ||

    (match.match_date == Date.today &&
      Time.now.utc < match_time.utc)
  end

  def details
    picks = match.picks.map(&:pick).compact.select{|p| p != 0}
    return '' if picks.empty?
    avg = picks.inject(0.0) {|s, v| s + v} / picks.size
    "#{description_with(pick)} (#{description_with(avg)})"
  end

  private
  def description_with(points)
    return "" if points.blank? || points == 0
    return "#{match.home_team.try(:short_name)} by #{"%.1f" % points}" if points > 0
    "#{match.home_team.try(:short_name)} by #{"%.1f" % points.abs}"
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
    kick_off = (match.kick_off - 1).to_s.gsub(/\./,':')
    Time.parse("#{Date.today} #{kick_off}0M")
  end
end
