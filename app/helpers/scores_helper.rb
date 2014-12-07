module ScoresHelper
  def points_for(match, user)
    pick = match.picks.find_by(user_id: user.id)
    if match.result.try(:home_team)
      "#{points_for_pick(match, pick)} <span class='small'>(#{selection_for(pick) || 'none'})</span>"
    elsif pick && pick.pick != 0
      "<span class='small'>(#{selection_for(pick)})</span>"
    else
      return '&nbsp;'
    end
  end

  private
  def selection_for(pick)
    pick.try(:description_with, pick.try(:pick))
  end

  def points_for_pick(match, pick)
    match.points_for_pick(pick.try(:pick) || 0)
  end
end
