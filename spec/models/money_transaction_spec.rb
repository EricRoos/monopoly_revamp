require 'rails_helper'

RSpec.describe MoneyTransaction, type: :model do
  describe '::create' do
    context 'no amount provided' do
      it 'raises an error' do
        expect(MoneyTransaction.create(player: FactoryBot.create(:player)).persisted?).to be_falsey
      end
    end
  end
end
