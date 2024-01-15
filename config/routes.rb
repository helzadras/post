Rails.application.routes.draw do
  resources :exp_transactions
  resources :acc_transactions
  devise_for :users

  authenticated :user do
    root to: 'dashboard#index', as: :authenticated_root
  end

  resources :transactions
  resources :expenses
  resources :accounts
 
  resources :accounts do
    resources :expenses
  end

  resources :accounts do
    resources :transactions
  end

  resources :expenses do
    resources :transactions
  end
  
  resources :accounts do
    resources :acc_transactions
  end
  
  resources :accounts do
    resources :exp_transactions
  end

  resources :expenses do
    member do
      get 'add_funds'
      get 'pay'
    end
  end

  resources :expenses do
    # other individual expense routes...
    collection do
      post 'fund_all_expenses'
    end
  end
 
  post 'expenses/fund_all_expenses', to: 'expenses#fund_all_expenses', as: 'fund_all_expenses'

  
  
  root to: "dashboard#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
end
