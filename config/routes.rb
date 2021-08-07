Rails.application.routes.draw do
  
  root to: "home#index"
  #devise_for :users
  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :confirmations => "users/confirmations"
    

  }

  resources :companies
  get "companies-list", to: "companies#list"
  get "employees", to: "companies#employee"

  

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
