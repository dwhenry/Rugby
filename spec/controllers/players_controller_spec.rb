require 'rails_helper'

describe PlayersController do
  include Authlogic::TestCase
  setup :activate_authlogic # run before tests are executed

  let(:user) { FactoryGirl.create(:user) }
  let(:league) { League.create!(name: 'temp') }

  before { UserSession.create(user) } # logs a user in

  describe '#destroy' do
    let!(:player) { FactoryGirl.create(:player, user: user) }
    let!(:other_player) { FactoryGirl.create(:player) }

    context 'when user is not admin' do
      it 'can delete a player for the current user' do
        expect do
          delete :destroy, id: player.id
        end.to change {
          Player.count
        }.by(-1)
      end

      it 'can not delete a player that is for a different user' do
        expect do
          delete :destroy, id: other_player.id
        end.not_to change {
          Player.count
        }
      end
    end

    context 'when user is admin' do
      before do
        user.update_attributes(admin: true)
      end

      it 'can delete a player that is for a different user' do
        expect do
          delete :destroy, id: other_player.id
        end.to change {
          Player.count
        }.by(-1)
      end
    end
  end
end
