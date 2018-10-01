Rails.application.routes.draw do
  get 'braintree/new'
  post 'braintree/checkout'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :show, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :listings, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resources :reservations
  end




  # resources :reservations, only: [ :new]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  root 'welcome#index'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"


  # get '/' => 'welcome#index'
end
