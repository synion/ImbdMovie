Rails.application.routes.draw do
  resources :genres
  resources :movies
  devise_for :users

  root 'movies#index'
end
