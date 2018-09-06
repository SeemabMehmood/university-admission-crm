Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, except: [:create, :destroy] do
    get 'get_user_data'
    get 'agent_branch_officers'
    post 'change_status'
  end

  resources :representing_countries, except: [:destroy] do
    post 'change_status'
  end

  root 'home#index'
  get 'home/index', to: 'home#index'
end
