Rails.application.routes.draw do

  get '/', to: 'welcome#index', as: 'welcome'

  get '/about', to: 'welcome#about', as: 'about'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
