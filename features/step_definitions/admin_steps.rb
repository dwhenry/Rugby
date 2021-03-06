When /^user enters results$/ do
  click_on 'Results'
  page.should have_css('.result_row input[type=text]')
  fill_in 'Home', :with => 5
  fill_in 'Away', :with => 10
  click_on 'Update'
end

Then /^can see updated points$/ do
  click_on 'Results'
  match = Match.last
  text = "#{match.away_team.short_name} by 5"
  page.should have_css('.result', :text => text)
end

Then /^user can not update results$/ do
  click_on 'Results'
  page.should have_no_css('.result_row input[type=text]')
end
