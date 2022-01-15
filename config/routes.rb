Rails.application.routes.draw do
  resources :locations
  resources :trips
 


  # User signup and sessions
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # Current_user
  get '/authenticate', to: 'users#show'

  # root
  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }

end
