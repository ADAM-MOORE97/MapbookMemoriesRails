Rails.application.routes.draw do
  # resources :locations
  resources :trips
  resources :locations
 


  # User signup and sessions
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # Current_user
  get '/authenticate', to: 'users#show'
  

  # root
get '/', to: 'welcome#index'

end
