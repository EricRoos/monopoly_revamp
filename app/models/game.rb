# frozen_string_literal: true

class Game < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :players
  has_many :invitations
  has_many :users, through: :players
  validates_presence_of :user
  alias owner user

  after_create :add_creator_as_player

  aasm column: 'state' do
    state :setting_up, initial: true
    state :playing
    state :finished

    event :start_game do
      transitions from: [:setting_up], to: :playing
    end

    event :end_game do
      transitions from: [:playing], to: :finished

    end
  end

  def add_player(new_user)
    Player.create(user: new_user, game: self) if setting_up?
  end

  def send_money(playerSender, playerReceiver, amount)
    if playing? && playerSender.can_spend?(amount) && (playerSender.game == playerReceiver.game) && playerSender.game == self
      ActiveRecord::Base.transaction do
        MoneyTransaction.create(player: playerSender, amount: -1 * amount)
        MoneyTransaction.create(player: playerReceiver, amount: amount)
      end
    end
  end

  private

  def add_creator_as_player
    add_player(user)
  end
end
