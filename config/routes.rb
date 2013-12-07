RhokBrisbane2013::Application.routes.draw do
  root to: 'application#index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
