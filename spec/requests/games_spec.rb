require 'rails_helper'

RSpec.describe 'Games', type: :request do
  context 'html' do
    describe '#show' do
      let(:user) { FactoryBot.create(:user) }
      let(:game) { FactoryBot.create(:game) }
      context 'user is not part of the game' do
        it 'does not allow the user to view' do
          sign_in user
          get game_path(game)
          expect(response).to have_http_status(:found)
        end
      end

      context 'user is part of the game' do
        before do
          FactoryBot.create(:player, game: game, user: user)
        end
        it 'shows a game' do
          sign_in user
          get game_path(game)
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  context 'js' do
    describe 'creating a new game' do
      context 'logged in' do
        it 'creates a new game' do
          sign_in FactoryBot.create(:user)
          post games_path, xhr: true
          expect(response).to have_http_status(201)
          expect(Game.count).to eq(1)
        end
      end
      context 'not logged in' do
        it 'does not create a new game' do
          post games_path, xhr: true
          expect(response).to have_http_status(401)
          expect(Game.count).to eq(0)
        end
      end
    end
  end
end
