class TeamsController < ApplicationController
  before_filter :require_user

  def index
    @teams = Team.team_by_pool
  end
end
