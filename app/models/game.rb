class Game < ApplicationRecord
  belongs_to :user
  has_many :players
  has_many :invitations
  has_many :users, through: :players
  validates_presence_of :user
  alias_method :owner, :user

  after_create :add_creator_as_player


  def add_player(new_user)
    Player.create(user: new_user, game: self)
  end

  def send_money(playerSender, playerReceiver, amount)
    if playerSender.can_spend?(amount) && (playerSender.game == playerReceiver.game) && playerSender.game == self
      ActiveRecord::Base.transaction do
        MoneyTransaction.create(player: playerSender, amount: -1 * amount)
        MoneyTransaction.create(player: playerReceiver,  amount: amount)
      end
    end
  end

  private

  def add_creator_as_player
    add_player(user)
  end
end
