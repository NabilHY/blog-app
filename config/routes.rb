Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
  end
  resources :posts, only: [:new, :create, :update, :destroy] do
    resources :comments
    resources :likes
  end

  get 'api/user/:id/posts' => 'users#user_posts_api', format: 'json'
  get 'api/post/:id/comments' => 'posts#post_comments_api', format: 'json'
  post 'api/post/:id/comments' => 'comments#post_create_api'
end
