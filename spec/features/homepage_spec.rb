require 'rails_helper'

RSpec.feature "Create Game", :type => :feature, js: true do
  let(:password) { 'test123456' }
  scenario "User has no prior games" do
    visit root_path
    expect(page).to have_content('Monopoly')
  end
end
