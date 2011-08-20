class LeagueMembersController < ApplicationController
  before_filter :require_user

  def create
    league_member = LeagueMember.new(params[:league_member])
    if league_member.save
      redirect_to main_index_path
    else
      @league = League.all
      render :template => "leagues/index"
    end
  end

  def destroy
    LeagueMember.find(params[:id]).delete
    redirect_to main_index_path
  end
end
