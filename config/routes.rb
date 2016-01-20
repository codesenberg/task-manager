Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :confirmations]
  root 'welcome#home'

  resources :task
end
