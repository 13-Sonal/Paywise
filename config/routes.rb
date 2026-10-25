Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/api/v1/users", to: "api/v1/users#index"
  get "/api/v1/salaries", to: "api/v1/salary_records#index"
  post "/api/v1/salaries", to: "api/v1/salary_records#update"
  get "/api/v1/historic_records", to: "api/v1/employment_histories#index"
  post "/api/v1/login", to: "api/v1/sessions#create"
  resources :users
  resources :employment_histories
  resources :salary_records
  resources :past_checks 
end
