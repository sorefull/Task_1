Rails.application.routes.draw do

  # admin
  namespace :admin do
    resources :users, except: [:show, :new, :create]
  end

  # welcome
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'welcome#about', as: 'about'

  # session
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create_social'
  delete '/logout',  to: 'sessions#destroy'

  # user
  resources :users, except: [:index, :edit, :destroy, :new] do
    resource :image, only: [:show, :update]
    collection do
      get :signup, to: 'users#new'
    end
  end

  # feed
  resources :feeds, only: :index

  # post
  resources :posts, except: [:edit] do
    resources :comments, only: [:create, :destroy, :update]
    resource :image, only: [:show, :update]
  end

  # APIs
  namespace :api, defaults: { format: :json } do
    get 'users', to: 'admins#index', as: 'users'
    resources :posts, only: [:index, :show]
    resources :users, only: :show do
      collection do
        get :sign_in
        get :feed
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
