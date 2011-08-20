require 'spec_helper'

require "authlogic/test_case" # include at the top of test_helper.rb

describe LeagueMembersController do
  include Authlogic::TestCase
  setup :activate_authlogic # run before tests are executed

  def valid_attributes
    {:league_id => 1, :user_id => 3}
  end

  let(:user) { User.create(:login => 'test', :email => 'test@email.com',
                           :password => 'password', :password_confirmation => 'password') }
  before do
    UserSession.create(user) # logs a user in
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new League" do
        expect {
          post :create, :league_member => valid_attributes
        }.to change(LeagueMember, :count).by(1)
      end

      it "redirects to the main page" do
        post :create, :league_member => valid_attributes
        response.should redirect_to(main_index_path)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        LeagueMember.any_instance.stub(:save).and_return(false)
        post :create, :league_member => {}
        response.should render_template("leagues/index")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested league" do
      league = LeagueMember.create! valid_attributes
      expect {
        delete :destroy, :id => league.id.to_s
      }.to change(LeagueMember, :count).by(-1)
    end

    it "redirects to the leagues list" do
      league = LeagueMember.create! valid_attributes
      delete :destroy, :id => league.id.to_s
      response.should redirect_to(main_index_path)
    end
  end
end
