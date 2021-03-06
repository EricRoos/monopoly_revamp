# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    if request.format.js?
      render 'shared/js_error', status: :unauthorized
    else
      redirect_to(request.referrer || root_path)
    end
  end
end
