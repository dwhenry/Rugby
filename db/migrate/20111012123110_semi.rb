class Semi < ActiveRecord::Migration
  def self.up
     [['Win Q1 v Win Q2', 'WAL', 'FRA'],
     ['Win Q3 v Win Q4', 'AUS', 'NZL']].each do |name, home, away|
       debugger
       match = Match.find_by_name(name)
       match.home_team = Team.find_by_short_name(home)
       match.away_team = Team.find_by_short_name(away)
       match.save
     end
  end

  def self.down
  end
end
