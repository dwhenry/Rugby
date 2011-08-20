class TeamsController < ApplicationController
  before_filter :require_user

  def index
    @teams = Team.all
  end
end
