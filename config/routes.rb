Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'index',            to: 'welcome#index'

  get 'courses/search',    to: 'welcome#search_courses'
  get 'courses/new',       to: 'welcome#new_course'
  get 'courses/:id',       to: 'welcome#course'
  get 'courses/:id/edit',  to: 'welcome#edit_course'
  post 'courses',          to: 'welcome#create_course'
  put 'courses/:id',       to: 'welcome#update_course'

  get 'webinars/search',   to: 'welcome#search_webinars'
  get 'webinars/new',      to: 'welcome#new_webinar'
  get 'webinars/:id',      to: 'welcome#webinar'
  get 'webinars/:id/edit', to: 'welcome#edit_webinar'
  post 'webinars',         to: 'welcome#create_webinar'
  put 'webinars/:id',      to: 'welcome#update_webinar'

  get 'profile',          to: 'welcome#profile'
  put 'profile',          to: 'welcome#update_user'
  get 'profile/edit',     to: 'welcome#edit_user'
  get 'register',         to: 'welcome#new_user'
  post 'register',        to: 'welcome#create_user'
  post 'forgot',          to: 'welcome#forgot'
end
