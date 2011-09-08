class FixNameForSarah < ActiveRecord::Migration
  def self.up
    User.first(:conditions => {:login => 'Nutter'}).update_attributes(:name => 'Sarah Nutter')
  end

  def self.down
  end
end
