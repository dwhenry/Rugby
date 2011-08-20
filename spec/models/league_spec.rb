require 'spec_helper'

describe League do
  subject { League.new }

  context "adding a users to a league" do
    let(:user) { mock_model(User) }
    it "adds the user" do
      subject.league_members.should_receive(:create).with(:user => user)
      subject.add_user(user)
    end
  end

  context 'with password confirmtion' do
    it 'allows password which is confirmed' do
      league = League.new(:name => 'Test',
                          :password => 'password',
                          :password_confirmation => 'password')
      league.should be_valid
    end

    it 'fails if password does not match' do
      league = League.new(:name => 'Test',
                          :password => 'password',
                          :password_confirmation => 'passwordi1')
      league.should_not be_valid
    end
  end

end
