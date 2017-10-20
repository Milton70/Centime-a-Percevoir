Rails.application.routes.draw do

  root 'sessions#login'
  resources :users, :sessions, :admin, :components

  get 	'sessions/login', 							to: 'sessions#login', 					as: 'login'
  post  'sessions/change_password/:id'  => 	'sessions#update_password',	as: 'update_password'

end
