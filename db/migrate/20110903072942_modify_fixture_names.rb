class ModifyFixtureNames < ActiveRecord::Migration
  def self.up
    Fixture.all.each do |fix|
      fix.name = fix.name.gsub(/Quarter /, 'Win Q')
      fix.description = fix.description.gsub(/Quarter /, 'Q')
      fix.description = fix.description.gsub(/Semi /, 'S')
      fix.name = fix.name.gsub(/Bronze Final/, 'Loss S1 v Loss S2')
      fix.name = fix.name.gsub(/Final/, 'Win S1 v Win S2')
      fix.save!
    end
  end

  def self.down
    Fixture.all.each do |fix|
      fix.name = fix.name.gsub(/Win Q/, 'Quarter ')
      fix.description = fix.description.gsub(/Q/, 'Quarter ') unless fix.name == fix.description
      fix.description = fix.description.gsub(/S/, 'Semi ') unless fix.name == fix.description
      fix.name = fix.name.gsub(/Loss S1 v Loss S2/, 'Bronze Final')
      fix.name = fix.name.gsub(/Win S1 v Win S2/, 'Final')
      fix.save!
    end
  end
end
