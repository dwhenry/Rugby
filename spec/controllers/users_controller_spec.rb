require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    let(:user) { mock_model(User) }
    before { User.stub(:new => user) }

    it "assigns a new user" do
      get 'new'
      assigns[:user].should == user
    end
  end

  describe "POST 'create'" do
    let(:params) { mock(:params) }
    let(:user) { mock_model(User, :save => true) }
    before { User.stub(:new => user) }

    it "create a user from the params" do
      User.should_receive(:new).with(params)
      post 'create', :user => params
    end
  end

end
