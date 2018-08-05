require 'rails_helper'

RSpec.feature "Create Game", :type => :feature, js: true do
  let(:password) { 'test123456' }
  scenario "User has no prior games" do
    user = FactoryBot.create(:user, password: password )
    login_as(user)
    visit games_path
    click_on "Create Game"
    wait_for_ajax
    expect(Game.count).to eq(1)
    expect(page).to have_content('Game')
  end
end
