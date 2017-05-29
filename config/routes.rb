Rails.application.routes.draw do
  namespace :v1 do
    resources :users
  end
  namespace :v2 do
    resources :users
  end
end
