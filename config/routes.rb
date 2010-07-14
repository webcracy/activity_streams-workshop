ActionController::Routing::Routes.draw do |map|

  map.resources :activities
  map.resources :oauth_consumers,:member=>{:callback=>:get}
  map.resources :users
  map.resource :session
  map.permalink '/a/:id', :controller => 'activities', :action => 'show_from_permalink'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'OauthConsumers', :action => 'index'
  
  map.root :controller => 'activities', :action => "new"
end
