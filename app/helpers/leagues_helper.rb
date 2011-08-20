module LeaguesHelper
  def join_leave(league)
    if league.users.include?(@current_user)
      league_member = league.league_members.detect{|lm| lm.user == @current_user}
      link_to('leave', league_member_path(league_member), :method => :delete)
    else
      link_to('join', league_members_path(:league_member => {:league_id => league,
                                                             :user_id => @current_user}),
                                          :method => :post)
    end
  end
end
