require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#valid?' do
    context 'doesnt have a user' do
      it 'is not valid' do
        expect(subject.valid?).to be false
      end
    end
  end

  describe '#add_player' do
    let(:new_user){FactoryBot.create(:user)}
    let(:game){ FactoryBot.create(:game) }
    before :each do
      game.add_player(new_user)
      game.reload
    end
    it 'adds the player' do
      expect(game.players.size).to eq(2)
      expect(game.players.first.user).to eq(game.user)
      expect(game.players.second.user).to eq(new_user)
    end
  end

  describe '::create' do
    let(:game){ FactoryBot.create(:game) }
    before :each do
      game.reload
    end
    it 'makes the creator a player' do
      expect(game.players.first.user).to eq(game.user)
    end
  end
end
