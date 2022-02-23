Rails.application.routes.draw do
  devise_for :users
  
  resources :users
  resources :items
end
