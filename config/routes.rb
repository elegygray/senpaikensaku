Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  get 'users/:user_id/comment', to: 'comments#new'
  post 'users/:user_id/comment', to: 'comments#create'
  resources :users, only: [:index, :edit, :update, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end
  end
  resources :information
  resources :relationships, only: [:create, :destroy]
end
