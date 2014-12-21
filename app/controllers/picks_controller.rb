class PicksController < ApplicationController
  before_filter :require_user

  def index
    @picks = current_user.get_picks
  end

  def create
    current_user.add_picks(params[:picks])
    redirect_to picks_path
  end
end
