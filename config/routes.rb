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
      get 'step2'
      get 'step3'
      get 'step4'
      get 'done'
      get 'mypage'
    end
  end
end
