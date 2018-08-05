require 'rails_helper'

RSpec.describe 'Invitations', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_two) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game, user: user) }
  context 'js' do
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
