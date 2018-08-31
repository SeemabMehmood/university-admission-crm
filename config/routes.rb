Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, except: [:create] do
    post 'change_status'
  end

  root 'home#index'
  get 'home/index', to: 'home#index'
end
