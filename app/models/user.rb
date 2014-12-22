class User < ActiveRecord::Base
  acts_as_authentic do |c|
    #c.my_config_option = my_value
  end

  has_many :players
  has_many :leagues, :through => :players
  has_many :picks
  belongs_to :team
  after_create :add_to_all_user_league

  validates_presence_of :login
  validates_presence_of :name

  def points
    Match.includes(:sides).all.map do |match|
      pick = picks.detect{ |p| p.match_id == match.id }.try(:pick) || 0
      match.points_for_pick(pick)
    end.sum
  end

  def add_to_all_user_league
    League.find_by(name: 'All Users').try(:add_user, self, nil)
  end

  def get_picks
    picks_by_match_id = picks.group_by(&:match_id)
    Match.all.map do |match|
      picks_by_match_id[match.id].try(:first) ||
        Pick.new(match: match, user: self)
    end
  end

  def current_picks
    []
  end

  def add_picks(added_picks)
    picks_by_match_id = picks.group_by(&:match_id)
    added_picks.each do |_, added_pick|
      next unless pick.can_set?
      pick = picks_by_match_id[added_pick[:match_id].to_i].try(:first) ||
        Pick.new(:match_id => added_pick[:match_id], :user => self)

      pick.set(added_pick[:team_id], added_pick[:margin]) if added_pick[:margin].present?
      pick.save
    end
  end
end
