class MakeMeAdmin < ActiveRecord::Migration
  def self.up
    User.first(:conditions => {:login => 'dw_henry'}).update_attributes(:admin => true)
  end

  def self.down
  end
end
