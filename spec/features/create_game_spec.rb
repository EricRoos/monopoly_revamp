require 'rails_helper'

RSpec.feature "Create Game", :type => :feature, js: true do
  scenario "User has no prior games" do
    password = 'test123456'
    user = FactoryBot.create(:user, password: password )
    login_as(user)
    sleep 5
    visit games_path
    click_on "Create Game"
    wait_for_ajax
    expect(page).to have_content('Game')
    expect(page).to have_css('#players')
  end
end
