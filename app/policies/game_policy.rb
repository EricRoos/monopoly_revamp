class GamePolicy < ApplicationPolicy
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end

  def show?
    game.user == user || game.users.include?(user)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
