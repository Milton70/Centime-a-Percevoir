Rails.application.routes.draw do

  root 'sessions#login'
  resources :users, :sessions, :admin

  get 'sessions/login', to: 'sessions#login', as: 'login'

end
