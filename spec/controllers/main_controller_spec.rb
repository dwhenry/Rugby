require 'spec_helper'

describe MainController do
  before { controller.stub(:require_user => true) }

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
