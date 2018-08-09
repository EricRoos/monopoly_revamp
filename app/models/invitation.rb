# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_one :sender, through: :game, foreign_key: :user_id, source: :user
  validates_uniqueness_of :user, scope: :game

  before_create :check_if_player_exists

  def accept
    unless player_exists?
      ActiveRecord::Base.transaction do
        Player.create(user: user, game: game)
        update_attributes(declined: false)
      end
    end
  end

  def decline
    update_attributes(declined: true) unless player_exists?
  end

  protected

  def player_exists?
    Player.exists?(game_id: game.id, user_id: user.id)
  end

  def check_if_player_exists
    throw :abort if player_exists?
  end
end
