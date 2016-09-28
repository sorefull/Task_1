Rails.application.routes.draw do

  # welcome
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'welcome#about', as: 'about'

  # session
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # user
  resources :users
  get 'signup', to: 'users#new'

  # post
  resources :posts, except: [:edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
