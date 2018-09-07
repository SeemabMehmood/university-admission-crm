Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  resources :users, except: [:create, :destroy] do
    get 'get_user_data'
    get 'agent_branch_officers'
    post 'change_status'
  end

  resources :representing_countries, except: [:destroy] do
    collection do
      get 'get_agent_representing_countries'
    end
    post 'change_status'
  end

  root 'home#index'
  get 'home/index', to: 'home#index'
end
