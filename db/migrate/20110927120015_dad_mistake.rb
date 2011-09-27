class DadMistake < ActiveRecord::Migration
  def self.up
    user = User.find_by_login('moorak')
    set_pick('CAN', 'JPN', 22, user)
  end

  def self.set_pick(home_team, away_team, value, user)
    puts "#{home_team}, #{away_team}"
    match = Match.all.detect{|m| m.home_team.short_name == home_team && m.away_team.short_name == away_team}
    puts match.name
    pick = match.picks.first(:conditions => {:user_id => user.id})
    pick = Pick.new(:match => match, :user_id => user.id) unless pick
    puts pick.inspect
    pick.update_attribute(:pick, value)
    puts pick.inspect
  end
  def self.down
  end
end
