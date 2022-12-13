Rails.application.routes.draw do
  get 'post_comments/create'
  get 'post_comments/destroy'
  get 'posts/show'
  get 'posts/index'
  get 'posts/create'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  get 'users/show'
  get 'users/index'
  get 'users/edit'
  get 'users/update'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
