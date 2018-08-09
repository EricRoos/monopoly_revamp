# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Create Game', type: :feature, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game) }
  scenario 'non player views a game' do
    sign_in user
    visit game_path(game)
    expect(page).to have_content('You are not authorized to perform this action.')
  end
end
