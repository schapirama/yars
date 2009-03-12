ActionController::Routing::Routes.draw do |map|
  
  # Authentication
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.amnesia '/amnesia', :controller => 'users', :action => 'amnesia'
  map.change_password '/change_password',    :controller => 'users', :action => 'change_password'
  map.confirm_change  '/cc/:id', :controller => 'users', :action => 'confirm_password_change'
  
  map.resources :users
  map.resource :session

  map.root :controller => "main"

  map.connect ':controller/:action/'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect ':action', :controller => 'main'
end