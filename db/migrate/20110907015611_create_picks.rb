class CreatePicks < ActiveRecord::Migration
  def self.up
    create_table :picks do |t|
      t.references :user
      t.references :match
      t.integer :pick

      t.timestamps
    end
  end

  def self.down
    drop_table :picks
  end
end
