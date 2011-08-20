class LoadFixtures < ActiveRecord::Migration
  def self.up
    data = File.read('db/fixtures.csv').split("\n").map{|r| r.gsub(/\"/,'').split(',')}[1..-1]

    data[0..39].each do |row|
      Fixture.create(:kick_off => row[1],
                     :home_team => get_team(row[3], :home, row[2]),
                     :away_team => get_team(row[3], :away, row[2]),
                     :location => "#{row[4]}, #{row[5]}",
                     :name => row[3],
                     :description => row[6])
    end

    data[40..-1].each do |row|
      Fixture.create(:kick_off => row[1],
                     :location => "#{row[4]}, #{row[5]}",
                     :name => row[3],
                     :description => row[6])
    end
  end

  def self.get_team(match, side, pool)
    index = side == :home ? 0 : 1
    name = match.split(' v ')[index]
    Team.find_by_name(name) || Team.create(:name => name, :pool => pool)
  end

  def self.down
    Team.delete_all
    Fixture.delete_all
  end
end
