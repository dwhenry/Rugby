class PlayersController < ApplicationController
  before_filter :require_user

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to league_path(@player.league_id)
    else
      @leagues = League.where.not(name: 'All Users')
      @all_league = League.find_by(name: 'All Users')
      render template: "leagues/index"
    end
  end

  def destroy
    if current_user.admin?
      Player.find_by(id: params[:id])
    else
      Player.find_by(id: params[:id], user_id: current_user.id)
    end.try(:delete)

    redirect_to main_index_path
  end

  def new
    @player = Player.new(player_params)
  end

  private

  def player_params
    params.require(:player).permit(
      :league_id,
      :password
    ).merge(user_id: current_user.id)
  end
end
