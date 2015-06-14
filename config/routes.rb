Concierge::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "public_searches#new" # "pages#show", :id => 1

  resources :public_searches

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations'
  }

  resources :tag_categories, except: [:show, :destroy]
  resources :comments,  only: [:create, :destroy]
  resources :dashboard, only: :index
  resources :kids
  resources :pages, except: :landing
  resources :saved_searches
  resources :tags
  resources :users, only: [:show, :edit, :index]
  resources :resource_categories, except: :destroy

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

