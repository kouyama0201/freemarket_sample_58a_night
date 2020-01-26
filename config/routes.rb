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

  resources :mypage do
    member do
      get 'exhibiting'
      get 'sold'
      get 'purchased'
      get 'profile'
      get 'card'
      get 'identification'
      get 'logout'
    end
  end

  resources :users, only: [:update]

  resources :products do
    member do
      patch 'release'
      patch 'suspension'
    end
    collection do
      get 'category_child', defaults: { format: 'json' }
      get 'category_grandchild', defaults: { format: 'json' }
      get 'size', defaults: { format: 'json' }
      get 'brand', defaults: { format: 'json' }
      get 'delivery_way'
    end
  end

  resources :card, only: [:new, :show, :create] do
    collection do
      get 'delete'
    end
  end

  resources :purchase do
    collection do
      get 'purchase_confirmation'
    end
    member do
      get 'pay'
    end
  end

end
