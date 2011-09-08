module LeaguesHelper
  def join_leave(league)
    if league.has_member?(@current_user)
      league_member = league.get_member(@current_user)
      link_to('leave', league_member_path(league_member), :method => :delete)
    elsif league.requires_password?
      link_to('join', new_league_member_path(:league_member => {:league_id => league,
                                                                :user_id => @current_user}))
    else
      link_to('join', league_members_path(:league_member => {:league_id => league,
                                                             :user_id => @current_user}),
                                          :method => :post)
    end
  end

  def display_error_message(league)
    return '' unless @league_member
    return '' unless league == @league_member.league
    return '' if @league_member.errors.empty?
    @league_member.errors.full_messages.map do |msg|
      content_tag('div', msg, :class => 'error')
    end.join
  end
end
