RhokBrisbane2013::Application.routes.draw do
  root to: 'application#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :resources
  resources :tags, only: :show
  resources :users, only: :show

  namespace :api, constraints: { format: /json/ } do
    namespace :v1 do
      resources :resources
      post 'search/people' => 'search#people'
      post 'search/resources' => 'search#resources'
    end
  end
end
