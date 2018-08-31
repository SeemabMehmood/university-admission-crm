Rails.application.routes.draw do
  devise_for :users

  resources :users do
    post 'change_status'
  end

  root 'home#index'
  get 'home/index', to: 'home#index'
end
