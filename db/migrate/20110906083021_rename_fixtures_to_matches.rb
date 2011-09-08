class RenameFixturesToMatches < ActiveRecord::Migration
  def self.up
    rename_table :fixtures, :matches
  end

  def self.down
    rename_table :matches, :fixtures
  end
end
