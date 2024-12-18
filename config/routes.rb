Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, only: [] do
    resources :tasks do
     resources :daily_task_tables
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check

  get '/current_user', to: 'current_user#index'
  
  # Defines the root path route ("/")
  # root "posts#index"
end
