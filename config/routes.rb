Rails.application.routes.draw do
  resources :money_transactions
  resources :players
  resources :games do
    resources :invitations
  end
  devise_for :users

  authenticated :user do
    root 'games#index', as: :authenticated_root
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
