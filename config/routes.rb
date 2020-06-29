Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'welcome/search'
  get 'welcome/index'
  get 'welcome/course'
  get 'welcome/profile'
  get 'welcome/webinar'
  root 'welcome#index'
end
