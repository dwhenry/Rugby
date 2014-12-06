class AddNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    User.reset_column_information
    User.find_by({:login => 'dw_henry'}).try(:update_attributes, :name => 'David Henry')
    User.find_by({:login => 'Maddy'}).try(:update_attributes, :name => 'Maddy Pratt')
    User.find_by({:login => 'crookie2935'}).try(:update_attributes, :name => 'Zak Cruickshank')
  end

  def self.down
    remove_column :users, :name
  end
end
