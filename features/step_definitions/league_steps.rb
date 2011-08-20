When /^I create a new league called "([^"]*)"(?: with password "([^"]*)")?$/ do |league_name, password|
  within('#right_menu') do
    click_on 'Create League'
  end
  fill_in 'League', :with => league_name
  if password
    fill_in 'Password', :with => password
    fill_in 'Password Confirmation', :with => password
  end
  click_on 'Create'
end

Then /^I should have leagues:$/ do |table|
  selectors = lambda do |row|
    [
      row.text
    ]
  end
  actual = tableish('#right_menu .league .element', selectors)
  table.diff!(actual)
end

Given /^a league called "([^"]*)"$/ do |league_name|
  League.create(:name => league_name)
end

When /^I click leagues$/ do
  click_on('All Leagues')
end

Then /^I should see leagues:$/ do |table|
  selectors = lambda do |row|
    [
      row.css('.name').text,
      row.css('.size').text,
      row.css('.password').text
    ]
  end
  actual = tableish('.all_leagues .league', selectors)
  table.diff!(actual)
end

When /^I join league "([^"]*)"$/ do |league_name|
  within('.all_leagues .league', :text => league_name) do
    click_on('join')
  end
end

