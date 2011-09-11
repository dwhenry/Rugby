class Result < ActiveRecord::Base
  attr_accessor :error_messages
  belongs_to :match

  def self.get_results
    Match.all.map do |match|
      result = all.detect{|p| p.match == match}
      Result.new(:match => match, :home_team => result.try(:home_team),
                 :away_team => result.try(:away_team))
    end
  end

  def self.add_results(added_results, user)
    added_results.map do |added_result|
      result = all.detect{|p| p.match_id == added_result[:match_id].to_i} ||
        Result.new(:match_id => added_result[:match_id])
      result.home_team = added_result[:home_team]
      result.away_team = added_result[:away_team]
      result.save if result.can_set?(user)
      return_result = Result.new(:match_id => added_result[:match_id],
                                 :home_team => added_result[:home_team],
                                 :away_team => added_result[:away_team])
      return_result.error_messages = result.errors.full_messages
      return_result
    end
  end

  def can_set?(user)
    user.admin? && 
      (match.match_date < Date.today ||
      (match.match_date == Date.today && Time.now.utc > match.match_finish_time.utc))
  end

  def details
    return 'Pending' if home_team.nil?
    "#{match.home_team.short_name} #{home_team} v #{match.away_team.short_name} #{away_team}"
  end

  def diff
    return nil unless home_team
    home_team - away_team
  end
end
