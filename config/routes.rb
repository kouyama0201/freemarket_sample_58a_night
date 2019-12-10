Rails.application.routes.draw do
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
    end
  end

end
