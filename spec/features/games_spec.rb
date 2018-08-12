# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Games', type: :feature, js: true do
  scenario 'non player views a game' do
    user = FactoryBot.create(:user)
    game = FactoryBot.create(:game)
    sign_in user
    visit game_path(game)
    expect(page).to have_content('You are not authorized to perform this action.')
  end

  scenario 'starting a game' do
    user = FactoryBot.create(:user)
    game = FactoryBot.create(:game, user: user)
    sign_in user
    visit game_path(game)
    click_on 'Start Game'
    wait_for_ajax
    expect(page).to have_content('Game Started!')
    expect(page).to_not have_content('Start Game')
    expect(page).to_not have_content('Send Invitation')
  end
end
