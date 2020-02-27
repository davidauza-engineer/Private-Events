Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'
  get '/create_event', to: 'events#new'
  post '/create_event', to: 'events#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/sign_up', to: 'users#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:index, :show, :new, :create]
  root 'sessions#new'
end
