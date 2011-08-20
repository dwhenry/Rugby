class CreateLeagueMember < ActiveRecord::Migration
  def self.up
    create_table :league_members do |t|
      t.references :user
      t.references :league

      t.timestamps
    end
  end

  def self.down
    drop_table :league_members
  end
end
