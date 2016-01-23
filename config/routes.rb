Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :confirmations]
  root 'welcome#home'

  resources :tasks do
    member do
      post :start
      post :finish
    end
  end

  resources :attachments, only: [:destroy] do
    member do
      get :download
    end

    collection do
      post 'add/:task_id', action: :add, as: :add
    end
  end
end
