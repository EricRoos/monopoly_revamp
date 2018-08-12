# frozen_string_literal: true

class InvitationPolicy < ApplicationPolicy
  attr_reader :user, :invitation
  delegate :game, to: :invitation

  def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def create?
    game.user == user && game.setting_up?
  end

  def accept?
    invitation.user == user && game.setting_up?
  end

  def decline?
    invitation.user == user && game.setting_up?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
