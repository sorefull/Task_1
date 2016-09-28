Rails.application.routes.draw do

  # admin
  get 'users', to: 'admins#index', as: 'users'
  delete 'users/:id', to: 'admins#destroy'
  get 'chenge/:id', to: 'admins#chenge_role', as: 'chenge_role'
  get 'block/:id', to: 'admins#chenge_status', as: 'chenge_status'

  # welcome
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'welcome#about', as: 'about'

  # session
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # user
  resources :users, except: [:index, :edit, :update, :destroy]
  get 'signup', to: 'users#new'

  # post
  resources :posts, except: [:edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
