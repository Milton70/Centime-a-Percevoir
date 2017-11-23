Rails.application.routes.draw do

  root 'sessions#login'
  resources :users, :sessions, :admin, :components, :test_cases, :test_executions

  get 	'sessions/login', 									to: 'sessions#login', 								as: 'login'
  post  'sessions/change_password/:id'  		=> 	'sessions#update_password',				as: 'update_password'

  post  'components/:id'										=>  'components#edit_param', 					as: 'edit_param'
  get 	'components/add_param/:id',					to: 'components#add_param', 					as: 'add_param'

  get		'test_cases/choose_components/:id',	to: 'test_cases#choose_components', 	as: 'test_cases_choose_components'
  get		'test_cases/edit_params/:id', 			to: 'test_cases#edit_params',					as: 'test_cases_edit_params' 	
  post 	'test_cases/edit_params/:id'				=> 	'test_cases#edit_params_1', 			as: 'test_cases_edit_params_1'

end
