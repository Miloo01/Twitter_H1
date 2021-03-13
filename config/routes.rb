Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    resources :likes
    member do
      post :retweet
    end
  end

  post 'user/:user_id', to: 'friends#create', as: 'friend_create'
  delete 'user/:user_id', to: 'friends#destroy', as: 'friend_destroy'

  get 'api/news'
  get 'api/:fecha1/:fecha2', to: 'api#search', as: 'ask_search'

  post 'api/create', to: 'api#create_tweet'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'tweets#index'
end
