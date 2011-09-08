class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.references :match
      t.integer :home_team
      t.integer :away_team

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
