# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'devise' do
    let(:email) { 'bob@bob.com' }
    let(:password) { 'password' }
    describe '#save' do
      before do
        User.create(email: email, password: password)
      end
      it 'saved with the email' do
        expect(User.where(email: email).first).to_not be_nil
      end
    end
  end

  describe '#create_game' do
    let(:user) { FactoryBot.create(:user) }
    it 'creates a game' do
      expect(user.create_game).to eq(Game.last)
    end
  end
end
