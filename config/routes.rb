Rails.application.routes.draw do
  root to: "homes#top"
  get "homes/about"=>"homes#about", as: 'about'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # deviseに新しくルーティングを追加
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :favorites
    end
  end

  resources :posts, only: [:index,:create,:show, :edit, :destroy, :update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
