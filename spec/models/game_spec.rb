require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#valid?' do
    context 'doesnt have a user' do
      it 'is not valid' do
        expect(subject.valid?).to be false
      end
    end
  end

  describe '#send_money' do
    let(:game) { FactoryBot.create(:game) }
    let(:sender) { FactoryBot.create(:player, game: game) }
    let(:receiver) { FactoryBot.create(:player, game: game) }
    let(:amount) { 20 }
    before :each do
      game.send_money(sender,receiver, amount)  
    end
    context 'sender has enough money' do
      it 'sends the money' do
        expect(sender.balance).to eql(Player::DEFAULT_BALANCE - amount)
        expect(receiver.balance).to eql(Player::DEFAULT_BALANCE + amount)
      end
    end

    context 'sender doesnt have enough money' do
      let(:amount) { Player::DEFAULT_BALANCE + 1 }
      it 'does not sends the money' do
        expect(sender.balance).to eql(Player::DEFAULT_BALANCE)
        expect(receiver.balance).to eql(Player::DEFAULT_BALANCE)
      end
    end

    context 'tries to send negative amount' do
      let(:amount) { -1 }
      it 'does not sends the money' do
        expect(sender.balance).to eql(Player::DEFAULT_BALANCE)
        expect(receiver.balance).to eql(Player::DEFAULT_BALANCE)
      end
    end

    context 'players are from different games' do
      let(:sender){FactoryBot.create(:player)}
      it 'does not sends the money' do
        expect(sender.balance).to eql(Player::DEFAULT_BALANCE)
        expect(receiver.balance).to eql(Player::DEFAULT_BALANCE)
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
