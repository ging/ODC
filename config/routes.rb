Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'search', to: 'welcome#search'
  get 'index', to: 'welcome#index'

  get 'course/new', to: 'welcome#new_course'
  get 'course/:id', to: 'welcome#course'
  get 'webinar/:id', to: 'welcome#webinar'

  get 'profile', to: 'welcome#profile'
  get 'profile/edit', to: 'welcome#edit_profile'
end
