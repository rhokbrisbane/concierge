RhokBrisbane2013::Application.routes.draw do
  ActiveAdmin.routes(self)

  root to: 'dashboard#index'


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :dashboard, only: :index
  resources :kids
  resources :saved_searches
  resources :resources, except: [:index]
  resources :tags, only: :show
  resources :users, only: :show do
    patch 'add_tag', on: :member
  end

  namespace :api, constraints: { format: /json/ } do
    namespace :v1 do
      resources :resources
      post 'search/people' => 'search#people'
      post 'search/resources' => 'search#resources'
    end
  end
end
