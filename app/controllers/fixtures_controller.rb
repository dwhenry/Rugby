class FixturesController < ApplicationController
  before_filter :require_user

  def index
    @fixtures = Fixture.all
  end
end
