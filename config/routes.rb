RhokBrisbane2013::Application.routes.draw do
  root to: 'application#index'

  devise_for :users
end
