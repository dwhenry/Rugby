class FixPicks < ActiveRecord::Migration
  def self.up
    user = User.find_by_login('oxford').id
    set_pick('SAM', 'NAM', 20, user)
    set_pick('TGA', 'CAN', 15, user)
    set_pick('SCO', 'GEO', 10, user)
    set_pick('RUS', 'USA', -4, user)

    user = User.find_by_login('Nutter').id
    set_pick('NZL', 'TGA', 35, user)
    set_pick('SCO', 'ROU', nil, user)
    set_pick('FIJ', 'NAM', nil, user)
    set_pick('FRA', 'JPN', nil, user)
    set_pick('ARG', 'ENG', nil, user)
    set_pick('AUS', 'ITA', nil, user)
    set_pick('IRL', 'USA', nil, user)
    set_pick('RSA', 'WAL', nil, user)
  end

  def self.set_pick(home_team, away_team, value, user)
    puts "#{home_team}, #{away_team}"
    match = Match.all.detect{|m| m.home_team.short_name == home_team && m.away_team.short_name == away_team}
    pick = match.picks.first(:conditions => {:user_id => user})
    pick = Pick.new(:match => match, :user_id => user) unless pick
    if value
      pick.update_attribute(:pick, value)
    else
      picks = match.picks(:include => :user, :conditions => ['users.id != ?', user])
      value = picks.map{|p| p.match.points_for_pick(p.pick)}.sum.to_f / picks.size
      if match.results.diff > 0
        value +=match.results.diff
      else
        value = match.result.diff - value
      end
      pick.update_attribute(:pick, value.to_i)
    end
  end

  def self.down
  end
end
