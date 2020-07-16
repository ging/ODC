MOVLE::Application.routes.draw do
  root "home#frontpage"

  #Users
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/users/:id/presentations' => 'users#show_presentations', via: [:get]
  match '/users/:id/files' => 'users#show_files', via: [:get]
  resources :users

  #Courses
  resources :courses
  match '/webinars', to: 'courses#webinars', via: [:get]
  match '/all_courses', to: 'courses#all_courses', via: [:get]

  #Locale
  match '/change_locale', to: 'locales#change_locale', via: [:get]

  #Thumbnails
  match '/thumbnails' => 'presentations#presentation_thumbnails', via: [:get]

  #Tags
  match "/tags" => 'tags#index', :via => :get

  #Search
  match "/search" => 'search#index', :via => :get

  #Terms of use
  match '/terms_of_use', to: "home#frontpage", via: [:get]

  #Wildcard route (This rule should be placed the last)
  match "*not_found", :to => 'application#page_not_found', via: [:get]
end