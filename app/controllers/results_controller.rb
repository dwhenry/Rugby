class ResultsController < ApplicationController
  before_filter :require_user

  def index
    @results = Result.get_results
  end

  def create
    @results = Result.add_results(params[:results], current_user)
    render 'index'
  end
end
