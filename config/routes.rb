ODC::Application.routes.draw do
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
  match 'courses/:id/enroll' => 'courses#enroll', via: [:post]
  match 'courses/:id/unenroll' => 'courses#unenroll', via: [:post]
  match 'courses/:id/rate' => 'courses#rate', via: [:post]
  match '/menrollment' => 'courses#menrollment', via: [:get]
  match '/menrollment' => 'courses#menrollment_create', via: [:post]

  #Locale
  match '/change_locale', to: 'locales#change_locale', via: [:get]

  #Thumbnails
  match '/thumbnails' => 'presentations#presentation_thumbnails', via: [:get]

  #Tags
  match "/tags" => 'tags#index', :via => :get

  #Search
  match "/search" => 'search#index', :via => :get
  match "/search_teachers" => 'search#teacher_search', :via => :get
  #Terms of use
  match '/terms_of_use', to: "application#terms_of_use", via: [:get]
  match '/help', to: "home#help", via: [:get]

  #Wildcard route (This rule should be placed the last)
  match "*not_found", :to => 'application#page_not_found', via: [:get]
end