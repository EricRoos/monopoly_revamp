# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvitationPolicy do
  let(:user) { User.new }
  let(:game) { Game.new }
  let(:invitation) { Invitation.new(user: user, game: game) }

  subject { described_class }

  permissions '.scope' do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    context 'user created the game' do
      let(:game) { FactoryBot.build(:game, user: user) }
      context 'game has started' do
        before do
          game.start_game
        end
        it 'rejects the action' do
          expect(subject).to_not permit(user, invitation)
        end
      end
      context 'game has not started' do
        it 'allows the action' do
          expect(subject).to permit(user, invitation)
        end
      end
    end
    context 'user did not create the game' do
      context 'game has not started' do
        it 'rejects the action' do
          expect(subject).to_not permit(user, invitation)
        end
      end
      context 'game has started' do
        before do
          game.start_game
        end
        it 'rejects the action' do
          expect(subject).to_not permit(user, invitation)
        end
      end
    end
  end
end
