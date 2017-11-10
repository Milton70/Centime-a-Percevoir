Rails.application.routes.draw do

  root 'sessions#login'
  resources :users, :sessions, :admin, :components

  get 	'sessions/login', 							to: 'sessions#login', 					as: 'login'
  post  'sessions/change_password/:id'  => 	'sessions#update_password',	as: 'update_password'

  post  'components/:id'								=>  'components#edit_param', 		as: 'edit_param'
  get 	'components/add_param/:id',			to: 'components#add_param', 		as: 'add_param'

end
