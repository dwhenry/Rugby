class AddNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    User.reset_column_information
    User.first(:conditions => {:login => 'dw_henry'}).update_attributes(:name => 'David Henry')
    User.first(:conditions => {:login => 'Maddy'}).update_attributes(:name => 'Maddy Pratt')
    User.first(:conditions => {:login => 'crookie2935'}).update_attributes(:name => 'Zak Cruickshank')
  end

  def self.down
    remove_column :users, :name
  end
end
