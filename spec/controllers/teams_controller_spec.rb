require 'rails_helper'

describe TeamsController do
  include Authlogic::TestCase
  setup :activate_authlogic # run before tests are executed

  def valid_attributes
    {:name => 'Team', :pool => 'A'}
  end

  let(:user) { User.create(:login => 'test', :email => 'test@email.com',
                           :password => 'password', :password_confirmation => 'password') }
  before do
    UserSession.create(user) # logs a user in
  end
  describe "GET index" do
    it "assigns all teams as @teams" do
      team = Team.create! valid_attributes
      get :index
      expect(assigns(:teams)).to eq('A' => [team])
    end
  end
end
