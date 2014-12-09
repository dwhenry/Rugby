class PlayersController < ApplicationController
  before_filter :require_user

  def create
    @player = Player.new(params.require(:player).permit(:user_id, :league_id, :password))
    if @player.save
      redirect_to league_path(@player.league_id)
    else
      @leagues = League.where.not(name: 'All Users')
      @all_league = League.find_by(name: 'All Users')
      render :template => "leagues/index"
    end
  end

  def destroy
    Player.find(params[:id]).delete
    redirect_to main_index_path
  end

  def new
    @player = Player.new(params.require(:player).permit(:user_id, :league_id, :league_password))
  end
end
