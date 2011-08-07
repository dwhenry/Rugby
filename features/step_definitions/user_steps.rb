When /^I create an account for user "([^"]*)"$/ do |user_name|
  click_on 'Register'
  fill_in 'Login', :with => user_name
  fill_in 'Email', :with => "#{user_name}@test.com"
  click_on 'Register'
end

Then /^I should be logged in as "([^"]*)"$/ do |arg1|
  within('#user') do
    page.should have_content 'David'
    page.should have_css('a', :text => 'logout')
  end
end

Given /^I have a user account for "([^"]*)"$/ do |arg1|
  User.create(:login => user_name, :email => "#{login}@test.com")
end

When /^I login as "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
