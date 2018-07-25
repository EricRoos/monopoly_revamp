require 'rails_helper'

RSpec.feature "User Registration", :type => :feature do
  let(:password) { 'test123456' }
  let(:email) { 'bob@1.com' }
  scenario "User registers" do
    visit new_user_registration_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_button "Sign up"
    expect(page).to have_text("Games")
  end
end
