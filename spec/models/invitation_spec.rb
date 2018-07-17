require 'rails_helper'

RSpec.describe Invitation, type: :model do

  describe '#accept' do
    let(:game) { FactoryBot.create(:game) }
    let(:user) { FactoryBot.create(:user) }
    let(:invitation) { FactoryBot.create(:invitation, user: user, game: game) }
    context 'user is not in the game' do
      it 'adds the user to the game as a player' do
        expect(invitation.accept).to_not be_nil
        expect(game.users).to include(user)
        expect(invitation.declined).to be false
      end   

    end
    context 'user is in the game' do
      before do
        invitation.accept
      end
      it 'does not add the user to the game' do
        expect(invitation.accept).to be_nil
      end
    end
  end

  describe '::create' do
    let(:game) { FactoryBot.create(:game) }
    let(:user) { FactoryBot.create(:user) }

    context 'no prior invitation' do
      it 'creates the invitation' do
        expect(FactoryBot.create(:invitation, game: game, user: user).id).to_not be_nil
      end
    end

    context 'prior invitation' do
      it 'does not create the second invitation' do
        FactoryBot.create(:invitation, game: game, user: user)
        expect{ FactoryBot.create(:invitation, game: game, user:user) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'user is a player in the game' do
      it 'does not create the second invitation' do
        FactoryBot.create(:player, user: user, game: game).as_json
        expect{ FactoryBot.create(:invitation, game: game, user:user) }.to raise_error(ActiveRecord::RecordNotSaved)
      end
    end
  end
end
