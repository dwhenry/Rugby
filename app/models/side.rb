class Side < ActiveRecord::Base
  belongs_to :match
  belongs_to :team

  def score_value
    return 0 if score.blank?
    side == 'home' ? score : -score
  end
end
