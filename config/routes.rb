Rails.application.routes.draw do
  resources :tweets do
    resources :likes
    member do
      post :retweet
    end

  end

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'tweets#index'
end
