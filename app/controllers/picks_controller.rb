class PicksController < ApplicationController
  before_filter :require_user

  def index
    @picks = current_user.get_picks
  end

  def create
    @picks = current_user.add_picks(params[:picks])
    render 'index'
  end
end
