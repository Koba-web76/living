
Rails.application.routes.draw do
  get "questions/index"
  get "questions/new"
  get "questions/create"
  get "questions/show"
  get "lectures/index"
  get "lectures/new"
  devise_for :users

  resources :users, only: [:show] # ユーザーマイページへのルーティング

  resources :tweets do
    collection do
      post :add_tag
      get :like   # ✅ これがtweets_like_pathを作る
    end

    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :tags, only: [:index]
  resources :questions, only: [:index, :new, :create, :show]

  resources :questions do
    resources :answers, only: [:create]
  end

  root 'tweets#index'

  get 'lectures/index'  => 'lectures#index'
  get 'lectures/new'  => 'lectures#new'
  post 'lectures/new'  => 'lectures#create'

end