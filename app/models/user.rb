class User < ActiveRecord::Base
  acts_as_authentic do |c|
    #c.my_config_option = my_value
  end

  has_many :league_members
  has_many :leagues, :through => :league_members
  belongs_to :team
end
