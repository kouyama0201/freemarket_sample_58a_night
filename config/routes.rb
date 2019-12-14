Rails.application.routes.draw do
  get 'card/new'

  get 'card/show'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
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

  resources :products do
    collection do
      get 'detail'
      get 'logout'
      get 'purchase_confirmation'
      get 'card'
      get 'card_registration'
      get 'mypage'
      get 'identification'
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
