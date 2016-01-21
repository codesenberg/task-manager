Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :confirmations]
  root 'welcome#home'

  resources :task do
    member do
      post :start
      post :finish
    end
  end
end
