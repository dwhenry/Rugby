Given /^Match for tomorrow$/ do
  MatchCreator.for_date(Date.today.advance(:days => 1))
end

Given /^Match for yesterday$/ do
  MatchCreator.for_date(Date.today.advance(:days => -1))
end

When /^I select a goal difference of Home by "([^"]*)"$/ do |points|
  click_on 'Picks'
  match = Match.last
  match_name = "#{match.home_team.short_name} v #{match.away_team.short_name}"
  within('.pick_row', :text => match_name) do
    fill_in 'Home', :with => points
  end
  click_on 'Update'
end

Then /^I have selections of Home by "([^"]*)"$/ do |points|
  click_on 'Picks'
  match = Match.last
  match_name = "#{match.home_team.short_name} v #{match.away_team.short_name}"
  within('.pick_row', :text => match_name) do
    page.should have_css('.pick', :text =>  "#{match.home_team.short_name} by #{points}")
  end
end

Given /^Match for today$/ do
  MatchCreator.for_date(Date.today)
end

Then /^can not select a goal difference for the match/ do
  click_on 'Picks'
  match = Match.last
  match_name = "#{match.home_team.short_name} v #{match.away_team.short_name}"
  within('.pick_row', :text => match_name) do
    page.should have_no_css('input')
  end
  click_on 'Update'
end

class MatchCreator
  def self.for_date(date)
    team_a = Team.create!(:name => 'Team A', :short_name => 'TMA', :pool => 'A')
    team_b = Team.create!(:name => 'Team B', :short_name => 'TMB', :pool => 'A')
    Match.create(:home_team => team_a, :away_team => team_b, :name => 'A v B',
                 :description => 'A v B', :match_date => date, :kick_off => 7,
                 :location => 'Anywhere')
  end
end
