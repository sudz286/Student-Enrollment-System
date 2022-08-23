Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "sessions#new"

  resources :users, only: [:show, :index]

  resources :students, only: [:index, :create, :new, :edit, :update, :destroy]

  resources :instructors, only: [:index, :create, :new, :edit, :update, :destroy]

  resources :courses

  resources :enrollments

  resources :waitlists

  resources :admins, only: [:edit, :update]

  # GET login form
  get "/login", to: "sessions#new"
  # POST sessions (login)
  post "/sessions", to: "sessions#create"
  # DELETE sessions (logout)
  delete "/sessions", to: "sessions#destroy"
end
