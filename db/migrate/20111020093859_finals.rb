class Finals < ActiveRecord::Migration
  def self.up
     [['Loss S1 v Loss S2', 'WAL', 'AUS'],
     ['Win S1 v Win S2', 'FRA', 'NZL']].each do |name, home, away|
       match = Match.find_by_name(name)
       match.home_team = Team.find_by_short_name(home)
       match.away_team = Team.find_by_short_name(away)
       match.save
     end
  end

  def self.down
  end
end
