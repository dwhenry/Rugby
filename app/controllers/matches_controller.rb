class MatchesController < ApplicationController
  before_filter :require_user

  def index
    @matches = Match.all
  end
end
