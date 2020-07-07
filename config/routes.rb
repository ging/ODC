Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'search',           to: 'welcome#search'
  get 'index',            to: 'welcome#index'

  get 'course/new',       to: 'welcome#new_course'
  get 'course/:id',       to: 'welcome#course'
  get 'course/:id/edit',  to: 'welcome#edit_course'
  post 'course',          to: 'welcome#create_course'
  put 'course/:id',       to: 'welcome#update_course'

  get 'webinar/new',      to: 'welcome#new_webinar'
  get 'webinar/:id',      to: 'welcome#webinar'
  get 'webinar/:id/edit', to: 'welcome#edit_webinar'
  post 'webinar',         to: 'welcome#create_webinar'
  put 'webinar/:id',      to: 'welcome#update_webinar'

  get 'profile',          to: 'welcome#profile'
  put 'profile',          to: 'welcome#update_user'
  get 'profile/edit',     to: 'welcome#edit_user'
  get 'register',         to: 'welcome#new_user'
  post 'register',        to: 'welcome#create_user'
  post 'forgot',          to: 'welcome#forgot'
end
