Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root to: 'products#index'
  resources :signup do
    collection do
      get 'registration'
      get 'phone'
      get 'address'
      get 'pay_way'
      get 'complete'
    end
  end

  resources :purchase,  only: [:show] do
    member do
      patch 'pay'
    end
    collection do
      get 'complete'
    end
  end

  resources :products do
    collection do
      get 'logout'
      get 'card'
      get 'card_registration'
      get 'mypage'
      get 'identification'
      get 'profile'
    end
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

end
