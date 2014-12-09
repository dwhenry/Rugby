class Result < OpenStruct
  def self.get_results
    Match.includes(:sides).all.map do |match|
      home_side, away_side = *match.sides

      Result.new(:match => match, :home_team => home_side.try(:score),
                 :away_team => away_side.try(:score))
    end
  end

  def self.add_results(added_results, user)
    matches = Match.includes(:sides).all
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
          match.errors << "Must set both home and away score"
        end
      end
    end
    matches
  end

  def details
    home_side, away_side = *match.sides
    return 'Pending' if home_side.score.blank?
    "#{home_side.team.short_name} #{home_side.score} v #{away_side.team.short_name} #{away_side.score}"
  end

  def diff
    match.sides.map(&:score_value).inject(:+)
  end
end
