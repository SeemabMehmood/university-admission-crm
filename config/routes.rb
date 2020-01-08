Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions',
                                    passwords: 'passwords' }

  resources :users, except: [:create] do
    get 'get_user_data'
    get 'agent_branch_officers'
    post 'change_status'
  end

  resources :representing_countries do
    collection do
      get 'get_agent_representing_countries'
    end
    post 'change_status'
  end

  resources :representing_institutions do
    collection do
      get 'get_institutions_from_country'
    end
    post 'change_status'
  end

  resources :email_templates, except: [:index]
  resources :applications do
    post 'update_status'
    get 'edit_status'
    get 'track_history'
    get 'admin_notes'
    post 'create_admin_notes'
    get 'forward'
    post 'forward_application'
    get 'reminder_email'
    post 'send_reminder_email'
  end

  resources :followups do
    post 'change_status'
  end

  get 'finance/income'
  get 'finance/income/:income_id/edit', to: 'finance#edit_income', as: :edit_income
  post 'finance/income/:income_id/update', to: 'finance#update_income', as: :update_income
  get 'finance/expense'
  get 'finance/expense/new', to: 'finance#new_expense', as: :new_expense
  post 'finance/expense/create', to: 'finance#create_expense', as: :create_expense
  get 'finance/expense/:expense_id/edit', to: 'finance#edit_expense', as: :edit_expense
  post 'finance/expense/:expense_id/update', to: 'finance#update_expense', as: :update_expense

  get 'reports/branch_offices', to: 'reports#branch_offices', as: :branch_offices_report
  get 'reports/counsellors', to: 'reports#counsellors', as: :counsellors_report

  post 'application_processes/:id/change_status', to: 'application_processes#change_status', as: :application_process_change_status
  post 'representing_institutions/:counsellor_id/assign_institutions', to: 'representing_institutions#assign_institutions', as: :assign_institutions
  post 'representing_institutions/:representing_institution_id/manage_counsellor/(:counsellor_id)', to: 'representing_institutions#manage_counsellor', as: :manage_counsellor

  root 'home#index'
  get 'home/index', to: 'home#index'
end
