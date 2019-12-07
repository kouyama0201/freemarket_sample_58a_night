Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  resources :products do
    collection do
      get 'detail'
      get 'logout'
    end
  end
end
