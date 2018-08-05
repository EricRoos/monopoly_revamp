require 'rails_helper'

RSpec.feature "Sending Invitations", :type => :feature, js: true do
  let(:user) {FactoryBot.create(:user) }
  let(:user_two) {FactoryBot.create(:user) }
  let(:game) {FactoryBot.create(:game, user: user) }
  scenario "sending an invitation" do
    login_as(user)
    visit game_path(game)
    expect(page).to have_content('Game')
    expect(page).to have_content('Send Invitation')
    fill_in 'invitation[user_id]', with: user_two.id
    click_button('Create Invitation')
    wait_for_ajax
    expect(page).to have_content('Invitation Sent!')
  end

  scenario "invite user twice" do
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

  scenario "not allowed to send an invitation" do
    login_as(user_two)
    visit game_path(game)
    expect(page).to have_content('Game')
    expect(page).to_not have_content('Send Invitation')
  end
end
