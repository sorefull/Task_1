Rails.application.routes.draw do

  # admin
  get 'users', to: 'admins#index', as: 'users'
  delete 'users/:id', to: 'admins#destroy'
  post 'chenge/:id', to: 'admins#chenge_role', as: 'chenge_role'
  post 'block/:id', to: 'admins#chenge_status', as: 'chenge_status'

  # welcome
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'welcome#about', as: 'about'

  # session
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create_fb'
  delete '/logout',  to: 'sessions#destroy'

  # user
  resources :users, except: [:index, :edit, :update, :destroy, :new] do
    member do
      get :following, :followers
      post :follow, :unfollow
    end
    collection do
      get :feed
      get :signup, to: 'users#new'
    end
  end

  # post
  resources :posts, except: [:edit, :update] do
    member do
      post :like, :unlike
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
