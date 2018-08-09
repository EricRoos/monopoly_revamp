# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Invitations', type: :feature, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:user_two) { FactoryBot.create(:user) }
  let(:game) { FactoryBot.create(:game, user: user) }
  scenario 'sending an invitation' do
    login_as(user)
    visit game_path(game)
    expect(page).to have_content('Game')
    expect(page).to have_content('Send Invitation')
    fill_in 'invitation[user_id]', with: user_two.id
    click_button('Create Invitation')
    wait_for_ajax
    expect(page).to have_content('Invitation Sent!')
  end

  scenario 'invite user twice' do
    login_as(user)
    visit game_path(game)
    expect(page).to have_content('Game')
    expect(page).to have_content('Send Invitation')
    fill_in 'invitation[user_id]', with: user_two.id
    click_button('Create Invitation')
    wait_for_ajax
    click_button('Create Invitation')
    wait_for_ajax
    expect(page).to_not have_content('Invitation Sent!')
    expect(page).to have_content('User already sent an invitation')
  end

  scenario 'accepting an invitation' do
    invite = Invitation.create(game: game, user: user_two)
    login_as(user_two)
    visit games_path
    expect(page).to have_content('(1) Invitation')
    click_on 'View All'
    wait_for_ajax
    expect(page).to have_content("Sent By: #{user.email}")
    click_on 'Accept'
    expect(page).to have_content('Game')
    expect(find('#players')).to have_content(user_two.email)
  end

  scenario 'declinig an invitation' do
    invite = Invitation.create(game: game, user: user_two)
    login_as(user_two)
    visit games_path
    expect(page).to have_content('(1) Invitation')
    click_on 'View All'
    wait_for_ajax
    expect(page).to have_content("Sent By: #{user.email}")
    click_on 'Decline'
    expect(page).to have_content('Declined')
  end

  scenario 'not allowed to send an invitation' do
    login_as(user_two)
    visit game_path(game)
    expect(page).to have_content('Game')
    expect(page).to_not have_content('Send Invitation')
  end
end
