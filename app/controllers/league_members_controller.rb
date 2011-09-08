class LeagueMembersController < ApplicationController
  before_filter :require_user

  def create
    @league_member = LeagueMember.new(params[:league_member])
    if @league_member.save
      redirect_to league_path(@league_member.league_id)
    else
      @leagues = League.all(:conditions => "name != 'All Users'")
      @all_league = League.first(:conditions => "name = 'All Users'")
      render :template => "leagues/index"
    end
  end

  def destroy
    LeagueMember.find(params[:id]).delete
    redirect_to main_index_path
  end

  def new
    @league_member = LeagueMember.new(params[:league_member])
  end
end
