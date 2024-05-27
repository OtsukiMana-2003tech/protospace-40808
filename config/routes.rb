Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes do              # prototypeコントローラーは7つのアクションすべての使用を許可する
    resources :comments, only: :create  # commentsコントローラーはcreateアクションのみ許可する
    collection do
      get 'search'
    end
  end
  resources :users, only: :show         # usersコントローラーはshowアクションのみ許可する
end