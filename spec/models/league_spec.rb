require 'rails_helper'

describe League do
  subject { League.new }

  context "adding a users to a league" do
    let(:user) { User.new }
    it "adds the user" do
      expect(subject.players).to receive(:create).with(user: user, password: nil)
      subject.add_user(user, nil)
    end
  end

  context 'with password confirmtion' do
    it 'allows password which is confirmed' do
      league = League.new(:name => 'Test',
                          :password => 'password',
                          :password_confirmation => 'password')
      expect(league).to be_valid
    end

    it 'fails if password does not match' do
      league = League.new(:name => 'Test',
                          :password => 'password',
                          :password_confirmation => 'passwordi1')
      expect(league).not_to be_valid
    end
  end

  context 'position for user' do
    let(:user) { create_user(10) }
    let(:other_user) { create_user(12) }
    subject { League.new }

    context 'when no users' do
      it 'shows 0 of 0' do
        expect(subject.position_for(user)).to eq '0 (0)'
      end
    end

    context 'when 1 user' do
      before { subject.users = [user] }
      it 'shows 1 of 1' do
        expect(subject.position_for(user)).to eq '1 (1)'
      end
    end

    context 'when 2 users' do
      context 'when 1st user' do
        before { subject.users = [user, other_user] }
        it 'shows 1 of 2' do
          expect(subject.position_for(user)).to eq '1 (2)'
        end
      end

      context 'when 2nd user' do
        before { subject.users = [other_user, user] }
        it 'shows 2 of 2' do
          expect(subject.position_for(user)).to eq '2 (2)'
        end
      end

      context 'when 2nd user and equal on points' do
        before do
          subject.users = [other_user, user]
          allow(other_user).to receive(:points).and_return(10)
        end

        it 'shows 1 of 2' do
          expect(subject.position_for(user)).to eq '1 (2)'
        end
      end
    end
  end

  def create_user(points)
    user = User.new
    allow(user).to receive(:points).and_return(points)
    user
  end
end
