module ScoresHelper
  def points_for(match, user)
    return '&nbsp;' unless match.result.try(:home_team)
    match.points_for_pick(match.picks.first(:conditions => {:user_id => user.id}).try(:pick) || 0)
  end
end
