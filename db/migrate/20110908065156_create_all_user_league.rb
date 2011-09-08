class CreateAllUserLeague < ActiveRecord::Migration
  def self.up
    l = League.create(:name => 'All Users')
    User.all.each do |user|
      l.add_user(user, nil)
    end
  end

  def self.down
    l = League.first(:conditios => {:name => 'All Users'})
    l.league_members.delete_all
    l.delete
  end
end
