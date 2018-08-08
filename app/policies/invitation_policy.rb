class InvitationPolicy < ApplicationPolicy
  attr_reader :user, :invitation

  def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def create?
    invitation.game.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
