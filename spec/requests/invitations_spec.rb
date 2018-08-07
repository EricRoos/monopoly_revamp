require 'rails_helper'

RSpec.describe 'Invitations', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_two) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game, user: user) }
  context 'js' do
    describe 'declining an invitation' do
      it 'declines the invitation' do
        sign_in user_two
        invitation = FactoryBot.create(:invitation, user: user_two, game: game)
        expect {
          put decline_invitation_path(invitation)
        }.to_not change{game.players.count}
        expect(response).to redirect_to(games_path)
      end

      context 'accepting for someone else' do
        it 'does not accept the invite'  do
          sign_in user
          invitation = FactoryBot.create(:invitation, user: user_two, game: game)
          put decline_invitation_path(invitation)
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
    describe 'accepting an invitation' do
      it 'accepts the invitation' do
        sign_in user_two
        invitation = FactoryBot.create(:invitation, user: user_two, game: game)
        expect {
          put accept_invitation_path(invitation)
        }.to change{game.players.count}.from(1).to(2)
        expect(response).to redirect_to(game_path(game))
      end

      context 'accepting for someone else' do
        it 'does not accept the invite'  do
          sign_in user
          invitation = FactoryBot.create(:invitation, user: user_two, game: game)
          put accept_invitation_path(invitation)
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    describe 'getting current users invitations' do
      before do
        sign_in user_two
      end

      it 'shows the invitations' do
        FactoryBot.create(:invitation, user: user_two, game: game)
        get invitations_path, xhr: true
        expect(response).to have_http_status(200)
      end
    end

    describe 'creating a new invitation' do
      context 'logged in' do
        before do
          sign_in user
        end

        context 'non game owner sends invitation' do
          it 'does not create the invitation' do
            post game_invitations_path(FactoryBot.create(:game, user: user_two)), params: {invitation: {user_id: user_two.id}}, xhr: true
            expect(response).to have_http_status(401)
          end
        end

        context 'game owner sends invitation' do
          it 'creates a new game' do
            post game_invitations_path(game), params: {invitation: {user_id: user_two.id}}, xhr: true
            expect(response).to have_http_status(201)
          end
        end

        context 'already sent an invittion' do
          before do
            post game_invitations_path(game), params: {invitation: {user_id: user_two.id}}, xhr: true
          end
          it 'does not create the invitation' do
            post game_invitations_path(game), params: {invitation: {user_id: user_two.id}}, xhr: true
            expect(response).to have_http_status(400)
          end
        end
      end
      context 'not logged in' do
        it 'does not create a new invitation' do
        end
      end
    end
  end
end
