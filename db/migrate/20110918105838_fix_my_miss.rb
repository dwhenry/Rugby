class FixMyMiss < ActiveRecord::Migration
  def self.up
    user = User.find_by_login('dw_henry')
    set_pick('WAL', 'SAM', 20, user)
    set_pick('ENG', 'GEO', 30, user)
    set_pick('FRA', 'CAN', 20, user)
  end

  def self.set_pick(home_team, away_team, value, user)
    puts "#{home_team}, #{away_team}"
    match = Match.all.detect{|m| m.home_team.short_name == home_team && m.away_team.short_name == away_team}
    pick = match.picks.first(:conditions => {:user_id => user})
    pick = Pick.new(:match => match, :user_id => user) unless pick
    if value
      pick.update_attribute(:pick, value)
    else
      debugger
      picks = match.picks(:include => :user, :conditions => ['users.id != ?', user])
      value = picks.map{|p| p.match.points_for_pick(p.pick)}.sum.to_f / picks.size
      if match.result.diff > 0
        value +=match.result.diff
      else
        value = match.result.diff - value
      end
      pick.update_attribute(:pick, value.to_i)
    end
  end

  def self.down
  end
end
