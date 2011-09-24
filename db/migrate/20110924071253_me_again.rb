class MeAgain < ActiveRecord::Migration
  def self.up
    user = User.find_by_login('dw_henry')
    set_pick('ENG', 'ROU', 50, user)

    match =  Match.all.detect{|m| m.home_team.short_name == 'RSA' && m.away_team.short_name == 'NAM'}
    user = User.find_by_login('Nutter')
    picks = Pick.all(:conditions => {:match_id => match.id, :user_id => user.id})
    puts picks.inspect
    picks.each(&:deleted)
    puts picks.inspect
    picks.each(&:delete)
    set_pick('RSA', 'NAM', 70, user)
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
