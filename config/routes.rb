RhokBrisbane2013::Application.routes.draw do
  root to: 'application#index'

  namespace :api do
    namespace :v1 do
      resources :resources, constraints: {:format => /json/}
    end
  end

  devise_for :users
end
