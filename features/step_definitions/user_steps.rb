When /^I create an account for user "([^\"]*)"$/ do |user_name|
  Team.create(:name => 'Australia', :pool => 'A')
  within('.content') do
    click_on 'Register'
  end
  fill_in 'Login', :with => user_name
  fill_in 'Name', :with => user_name
  fill_in 'E-Mail', :with => "#{user_name}@test.com"
  fill_in 'Password', :with => "password"
  fill_in 'Password Confirmation', :with => "password"
  select 'Australia', :from => 'My Team'
  within('form') do
    click_on 'Register'
  end
end

Then /^I should be logged in as "([^\"]*)"$/ do |arg1|
  within('#user') do
    page.should have_content 'David'
    page.should have_css('a', :text => 'Logout')
  end
end

Given /^I have a user account for "([^\"]*)"$/ do |user_name|
  team = Team.create(:name => 'Australia', :pool => 'A')
  User.create(:login => user_name, :name => user_name,
              :email => "#{user_name}@test.com", :password => 'password',
              :password_confirmation => 'password', :team => team)
end

When /^I login as "([^\"]*)"$/ do |user_name|
  within('.content') do
    click_on 'Login'
    fill_in 'Login', :with => user_name
    fill_in 'Password', :with => 'password'
    within('form') do
      click_on 'Login'
    end
  end
end

Given /^A logged in( Admin | )user "([^\"]*)"$/ do |admin, user_name|
  step %Q{I have a user account for "#{user_name}"}
  visit new_user_session_path
  fill_in 'Login', :with => user_name
  fill_in 'Password', :with => 'password'
  User.last.update_attributes(:admin => true) if admin == ' Admin '
  within('form') do
    click_on 'Login'
  end
end

