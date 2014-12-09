class ResultsController < ApplicationController
  before_filter :require_user

  def index
    @matches = Match.includes(:sides).all
  end

  def create
    @matches = Result.add_results(params[:match], current_user)
    render 'index'
  end
end
