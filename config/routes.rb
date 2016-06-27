Rails.application.routes.draw do
  resources :documents, only: [:index, :create]

  get '/search', to: 'search#index'

  root 'search#index'
end
