module Result
  extend self

  def add_results(added_results, user)
    matches = Match.includes(:sides, :teams).all

    added_results.each do |match_id, results|
      match = matches.detect{ |m| m.id == match_id.to_i }

      if match.can_set_score?(user)
        home_side, away_side = *match.sides
        home_result = results['sides'].detect{|id, _| id.to_i == home_side.id }.last['score'].presence
        away_result = results['sides'].detect{|id, _| id.to_i == away_side.id }.last['score'].presence

        if home_result && away_result
          home_side.score = home_result
          away_side.score = away_result
          match.save
        elsif home_result || away_result
          home_side.score = home_result
          away_side.score = away_result
          match.errors[:base] << "Must set both home and away score"
        end
      end
    end
    matches
  end
end
