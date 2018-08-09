# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamePolicy do
  let(:user) { User.new }
  let(:game) { Game.new }

  subject { described_class }

  permissions '.scope' do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    context 'user is part of the game' do
      before do
        allow(game).to receive(:users).and_return([user])
      end
      it 'allows the action' do
        expect(subject).to permit(user, game)
      end
    end

    context 'user is not part of the game' do
      it 'rejects the action' do
        expect(subject).to_not permit(user, game)
      end
    end
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
