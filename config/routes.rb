Rails.application.routes.draw do
  devise_for :users
  root to: "items#index" #localhost:3000の遷移先を指定する（root_pathの遷移先になる）
  resources :items
  resources :orders, only:[:create]
  #resources :users
end
