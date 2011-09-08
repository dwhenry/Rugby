class CreateFixtures < ActiveRecord::Migration
  def self.up
    create_table :fixtures do |t|
      t.date :match_date
      t.float :kick_off
      t.references :home_team
      t.references :away_team
      t.string :location
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :fixtures
  end
end
