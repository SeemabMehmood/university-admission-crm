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

  resources :representing_institutions, except: [:destroy] do
    post 'change_status'
  end

  resources :email_templates, except: [:index, :destroy]
  resources :applications, except: [:destroy]

  post 'application_processes/:id/change_status', to: 'application_processes#change_status', as: :application_process_change_status
  post 'representing_institutions/:counsellor_id/assign_institutions', to: 'representing_institutions#assign_institutions', as: :assign_institutions
  post 'representing_institutions/:representing_institution_id/manage_counsellor/(:counsellor_id)', to: 'representing_institutions#manage_counsellor', as: :manage_counsellor

  root 'home#index'
  get 'home/index', to: 'home#index'
end
