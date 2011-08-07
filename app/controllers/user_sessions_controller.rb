class UserSessionsController < ApplicationController
  def login
    UserSession.create(:login => "bjohnson", :password => "my password", :remember_me => true)
  end

  def logout
    session.destroy
  end
end
