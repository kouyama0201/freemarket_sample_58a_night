Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  # resources :products, only: [:index]
  resources :signup do
    collection do
      get 'registration'
      get 'phone'
      get 'address'
      get 'pay_way'
      get 'complete'
    end
  end

  resources :products do
    collection do
      get 'detail'
      get 'logout'
      get 'purchase_confirmation'
      get 'card'
      get 'card_registration'
      get 'mypage'
    end
  end
end
