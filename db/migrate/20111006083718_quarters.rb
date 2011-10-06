class Quarters < ActiveRecord::Migration
  def self.up
     [['Win C v 2nd D', 'IRL', 'WAL'],
     ['Win B v 2nd A', 'ENG','FRA'],
     ['Win D v 2nd C', 'RSA', 'AUS'],
     ['Win A v 2nd B', 'NZL', 'ARG']].each do |name, home, away|
       match = Match.find_by_name(name)
       match.home_team = Team.find_by_short_name(home)
       match.away_team = Team.find_by_short_name(away)
       match.save
     end
  end

  def self.down
  end
end
