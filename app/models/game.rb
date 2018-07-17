class Game < ApplicationRecord
  belongs_to :user
  has_many :players
  has_many :users, through: :players
  validates_presence_of :user
  alias_method :owner, :user

  after_create :add_creator_as_player


  def add_player(new_user)
    Player.create(user: new_user, game: self)
  end

  private

  def add_creator_as_player
    add_player(user)
  end

end
