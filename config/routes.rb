# frozen_string_literal: true

Rails.application.routes.draw do
  resources :money_transactions
  resources :players

  resources :invitations, only: [:index]
  put 'invitations/:id/accept', as: :accept_invitation, to: 'invitations#accept'
  put 'invitations/:id/decline', as: :decline_invitation, to: 'invitations#decline'
  resources :games do
    member do
      post :start
    end
    resources :invitations
  end
  devise_for :users

  authenticated :user do
    root 'games#index', as: :authenticated_root
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
