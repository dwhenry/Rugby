module Result
  extend self

  def add_results(added_results, user)
    matches = Match.includes(:sides, :teams).all

    added_results.each do |match_id, results|
      match = matches.detect{ |m| m.id == match_id.to_i }

      if match.can_set_score?(user)
        home_side, away_side = *match.sides

        home_side.score = results['sides'][home_side.id.to_s]['score'].presence
        away_side.score = results['sides'][away_side.id.to_s]['score'].presence

        if home_side.score && away_side.score
          match.save
        elsif home_side.score || away_side.score
          match.errors[:base] << "Must set both home and away score"
        end
      end
    end
    matches
  end
end
