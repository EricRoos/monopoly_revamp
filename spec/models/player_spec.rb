# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  describe '#can_spend?' do
    let(:player) { FactoryBot.create(:player) }
    let(:can_spend?) { player.can_spend?(spend_amount) }
    context 'has more than enough' do
      let(:spend_amount) { Player::DEFAULT_BALANCE - 1 }
      it 'can spend' do
        expect(can_spend?).to eq(true)
      end
    end

    context 'has less than enough' do
      let(:spend_amount) { Player::DEFAULT_BALANCE + 1 }
      it 'cannot spend' do
        expect(can_spend?).to eq(false)
      end
    end

    context 'has exactly enough' do
      let(:spend_amount) { Player::DEFAULT_BALANCE }
      it 'can spend' do
        expect(can_spend?).to eq(true)
      end
    end
  end

  describe '#balance' do
    let(:player) { FactoryBot.create(:player) }
    context 'after creation' do
      it 'has an initial balance' do
        expect(player.balance).to eql(Player::DEFAULT_BALANCE)
      end
    end

    context 'adding money' do
      let(:added_money) { 500 }
      before do
        FactoryBot.create(:money_transaction, player: player, amount: added_money)
      end
      it 'has the updated balance' do
        expect(player.balance).to eql(Player::DEFAULT_BALANCE + added_money)
      end
    end

    context 'subtracting money' do
      let(:subtracted_money) { -500 }
      before do
        FactoryBot.create(:money_transaction, player: player, amount: subtracted_money)
      end
      it 'has the updated balance' do
        expect(player.balance).to eql(Player::DEFAULT_BALANCE + subtracted_money)
      end
    end
  end
end
