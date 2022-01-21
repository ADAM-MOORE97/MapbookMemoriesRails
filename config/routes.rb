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
  # Location routes
  post '/locations/new', to: 'locations#create'
  get '/locations/:id', to: 'locations#show'

  # root
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }

end
