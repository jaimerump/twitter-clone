Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "tweets#index"

  authenticated :user do
    resources :tweets, only: [:new, :create, :edit, :update, :destroy]
    post '/tweets/:id/favorite', to: 'tweets#favorite', as: :favorite
    delete '/tweets/:id/favorite', to: 'tweets#unfavorite', as: :unfavorite

    post '/user/:id/follow', to: 'users#follow', as: :follow
    delete '/user/:id/follow', to: 'users#unfollow', as: :unfollow
  end

  resources :tweets, only: [:index]

  # /users/:id conflicts with Devise
  get '/user/:id', to: 'users#show', as: :user

end
