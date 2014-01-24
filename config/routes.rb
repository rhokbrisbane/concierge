Concierge::Application.routes.draw do
  ActiveAdmin.routes(self)

  root to: 'dashboard#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :categories, except: :show
  resources :comments,  only: [:create, :destroy]
  resources :dashboard, only: :index
  resources :kids
  resources :pages
  resources :resources
  resources :saved_searches
  resources :tags
  resources :users,      only: :show

  resources :resources do
    member do
      patch 'add_tag'
      patch 'remove_tag'
    end
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      patch 'add_tag'
      patch 'remove_tag'
    end
  end

  namespace :api, constraints: { format: /json/ } do
    namespace :v1 do
      resources :resources
      post 'search/people'    => 'search#people'
      post 'search/resources' => 'search#resources'
    end
  end
end
