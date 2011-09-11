class ScoresController < ApplicationController
  before_filter :require_user

  def index
    @users = User.all.sort_by(&:points)
    @matches = Match.all
  end
end
