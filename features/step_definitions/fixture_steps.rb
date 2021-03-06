Given /^Match for tomorrow$/ do
  MatchCreator.for_date(Date.today.advance(:days => 1))
end

Given /^Match for yesterday$/ do
  MatchCreator.for_date(Date.today.advance(:days => -1))
end

When /^I select a goal difference of Home by "([^"]*)"$/ do |points|
  click_on 'Picks'
  match = Match.last
  within('.pick_row', :text => match.match) do
    fill_in 'Home', :with => points
  end
  click_on 'Update'
end

Then /^I have selections of Home by "([^"]*)"$/ do |points|
  click_on 'Picks'
  match = Match.last
    page.should have_css('.pick', :text =>  "#{match.home_team.short_name} by #{points}")
  within('.pick_row', :text => match.match) do
  end
end

Given /^Match for today$/ do
  MatchCreator.for_date(Date.today)
end

Then /^can not select a goal difference for the match/ do
  click_on 'Picks'
  match = Match.last
  within('.pick_row', :text => match.match) do
    page.should have_no_css('input')
  end
  click_on 'Update'
end

class MatchCreator
  def self.for_date(date)
    team_a = Team.create!(:name => 'Team A', :short_name => 'TMA', :pool => 'A')
    team_b = Team.create!(:name => 'Team B', :short_name => 'TMB', :pool => 'A')
    Match.create!(
      name: 'A v B',
      description: 'A v B',
      match_date: date,
      kick_off: 7,
      location: 'Anywhere',
      sides: [
        Side.new(side: 'home', team: team_a),
        Side.new(side: 'away', team: team_b)
      ]
    )
  end
end
