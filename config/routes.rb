ODC::Application.routes.draw do
  root "home#frontpage"

  #Users
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks" }
  match '/users/:id/presentations' => 'users#show_presentations', via: [:get]
  match '/users/:id/files' => 'users#show_files', via: [:get]
  resources :users
  match '/users' => 'users#index', via: [:get]

  #Newsletters
  match '/newsletters/unsubscribe' => 'newsletters#unsubscribe', via: [:get]
  match '/newsletters/perform_unsubscribe' => 'newsletters#perform_unsubscribe', via: [:get]
  resources :newsletters
  match '/newsletter_count' => 'newsletters#calculate_newsletter_recipients', via: [:post]
  match '/newsletter_authoring_tool' => 'newsletters#builder', via: [:get]

  #Courses
  resources :courses
  match '/vamping' => 'courses#show', :defaults => { :id => '45' },  via: [:get]
  match '/webinars', to: 'courses#webinars', via: [:get]
  match '/all_courses', to: 'courses#all_courses', via: [:get]
  match 'courses/:id/enrollments' => 'courses#enrollments', via: [:get]
  match 'courses/:id/enroll' => 'courses#enroll', via: [:post]
  match 'courses/:id/unenroll' => 'courses#unenroll', via: [:post]
  match 'courses/:id/rate' => 'courses#rate', via: [:post]
  match '/menrollment' => 'courses#menrollment', via: [:get]
  match '/menrollment' => 'courses#menrollment_create', via: [:post]
  match '/metrics' => 'courses#metrics', via: [:get]

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
  match '/about', to: "home#about", via: [:get]

  get '/sitemap.xml' => 'sitemaps#index', defaults: { format: 'xml' }
  get "/robots.:format", to: "sitemaps#robots"

  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  #Wildcard route (This rule should be placed the last)
  match "*not_found", :to => 'errors#not_found', via: [:get]
end
