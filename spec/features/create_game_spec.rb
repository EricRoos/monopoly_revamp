require 'rails_helper'

RSpec.feature "Create Game", :type => :feature, js: true do
  let(:password) { 'test123456' }
  scenario "User has no prior games" do
    user = FactoryBot.create(:user, password: password )
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_button "Log in"
    visit games_path
    click_on "Create Game"
    puts page.body
    wait_for_ajax
    expect(Game.count).to eq(1)
  end
end
