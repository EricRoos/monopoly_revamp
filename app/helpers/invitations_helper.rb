# frozen_string_literal: true

module InvitationsHelper
  def display_invite_number(number)
    message = "(#{number}) Invitation"
    message.tap do |m|
      m << 's' if number > 1
    end
  end
end
