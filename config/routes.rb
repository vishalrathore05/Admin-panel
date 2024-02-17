Rails.application.routes.draw do
  resources :posts
  # devise_for :admins
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  devise_scope :admin do
    get '/admin', to: 'admins/sessions#new'
  end

  namespace :admins do
    resources :dashboards do
      get :index, on: :collection
    end
    resources :posts
    resources :podcasts

  end
  # mount ActionCable.server => '/cable'
end
