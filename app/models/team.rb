class Team < ActiveRecord::Base
  has_many :sides
  has_many :matches, through: :sides

  validates_presence_of :name
  validates_presence_of :pool

  default_scope { order('name') }

  def self.team_by_pool
    Team.order('name').group_by(&:pool)
  end
end
