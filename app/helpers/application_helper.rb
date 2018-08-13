# frozen_string_literal: true

module ApplicationHelper
  #http://daemonite.github.io/material/docs/4.1/components/alerts/
  def display_alert(type = :info, message)
    render partial: 'shared/alert_box', locals: {type: type, message: message}
  end

  def user_id_display(user)
    "User ID: ##{user.id}"
  end

  def resource_name
    :user
  end

  def resource
    @user ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
