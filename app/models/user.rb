class User < ActiveRecord::Base
  acts_as_authentic do |c|
    #c.my_config_option = my_value
  end

  has_many :league_members
  has_many :leagues, :through => :league_members
  has_many :picks
  belongs_to :team
  after_create :add_to_all_user_league

  validates_presence_of :login
  validates_presence_of :name

  def points
    0
  end

  def add_to_all_user_league
    League.first(:conditions => {:name => 'All Users'}).try(:add_user, self, nil)
  end

  def get_picks
    Match.all.map do |match|
      pick = picks.detect{|p| p.match == match}
      Pick.new(:match => match, :user => self, :pick => pick.try(:pick))
    end
  end

  def current_picks
    []
  end

  def add_picks(added_picks)
    added_picks.map do |added_pick|
      pick = picks.detect{|p| p.match_id == added_pick[:match_id].to_i} ||
        Pick.new(:match_id => added_pick[:match_id], :user => self)
      pick.home_team = added_pick[:home_team]
      pick.away_team = added_pick[:away_team]
      pick.save if pick.can_set?
      return_pick = Pick.new(:match_id => added_pick[:match_id], :user => self,
               :pick => pick.pick)
      return_pick.error_messages = pick.errors.full_messages
      return_pick
    end
  end
end
