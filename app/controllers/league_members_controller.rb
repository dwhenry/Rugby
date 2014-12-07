class LeagueMembersController < ApplicationController
  before_filter :require_user

  def create
    @league_member = LeagueMember.new(params.require(:league_member).permit(:user_id, :league_id, :password))
    if @league_member.save
      redirect_to league_path(@league_member.league_id)
    else
      @leagues = League.where.not(name: 'All Users')
      @all_league = League.find_by(name: 'All Users')
      render :template => "leagues/index"
    end
  end

  def destroy
    LeagueMember.find(params[:id]).delete
    redirect_to main_index_path
  end

  def new
    @league_member = LeagueMember.new(params.require(:league_member).permit(:user_id, :league_id, :league_password))
  end
end
