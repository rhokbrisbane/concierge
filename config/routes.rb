RhokBrisbane2013::Application.routes.draw do
  root to: 'application#index'

  resources :users

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :api, constraints: { format: /json/ } do
    namespace :v1 do
      resources :resources
    end
  end

end
