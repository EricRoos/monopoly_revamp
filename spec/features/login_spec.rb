# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'User Login', type: :feature do
  let(:password) { 'test123456' }
  let(:user) { FactoryBot.create(:user, password: password) }
  scenario 'User logs in' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button 'Log in'
    expect(page).to have_text("User ID: ##{user.id}")
  end

  scenario 'User fails to log in' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password + '*'
    click_button 'Log in'
    expect(page).to have_text('Invalid Email or password.')
  end
end
