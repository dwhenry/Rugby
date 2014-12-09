module LeaguesHelper
  def join_leave(league)
    if league.has_member?(@current_user)
      player = league.get_player(@current_user)
      link_to('leave', player_path(player), method: :delete)
    elsif league.requires_password?
      link_to(
        'join',
        new_player_path(player: { league_id: league, user_id: @current_user })
      )
    else
      link_to(
        'join',
        players_path(
          player: {
            league_id: league,
            user_id: @current_user
          }
        ),
        method: :post
      )
    end
  end

  def display_error_message(league)
    return '' unless @player
    return '' unless league == @player.league
    return '' if @player.errors.empty?
    @player.errors.full_messages.map do |msg|
      content_tag('div', msg, :class => 'error')
    end.join
  end
end
