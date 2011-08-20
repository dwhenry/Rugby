class LeagueMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :league

  validates_presence_of :user_id
  validates_presence_of :league_id
end
