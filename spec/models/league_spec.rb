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

  context 'position for user' do
    let(:user) { mock_model(User, :points => 10) }
    let(:other_user) { mock_model(User, :points => 12) }
    subject { League.new }

    context 'when no users' do
      it 'shows 0 of 0' do
        subject.position_for(user).should == '0 (0)'
      end
    end

    context 'when 1 user' do
      before { subject.users = [user] }
      it 'shows 1 of 1' do
        subject.position_for(user).should == '1 (1)'
      end
    end

    context 'when 2 users' do
      context 'when 1st user' do
        before { subject.users = [user, other_user] }
        it 'shows 1 of 2' do
          subject.position_for(user).should == '1 (2)'
        end
      end

      context 'when 2nd user' do
        before { subject.users = [other_user, user] }
        it 'shows 2 of 2' do
          subject.position_for(user).should == '2 (2)'
        end
      end

      context 'when 2nd user and equal on points' do
        before do
          subject.users = [other_user, user]
          other_user.stub(:points => 10)
        end

        it 'shows 1 of 2' do
          subject.position_for(user).should == '1 (2)'
        end
      end
    end
  end
end
