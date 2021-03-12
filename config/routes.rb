Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # 'コントローラ名#アクション名'
  # ということはtopppagesコントローラと対応するindexアクション(toppages/index.html.erb)の作成が必要
  root to: "toppages#index"
  
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  # 新規登録URLを/signupにするため設定
  # resources :users で生成される URL である /users/new は少し格好悪く思えます。
  # そんなときには get 'signup' のように個別に設定することで解決します。とのこと
  get "signup", to: "users#new"
  
  #必要なアクションだけを設定している
  # ブロックとして処理を追加した
  # memberとcollectionの違いは、:idがつく・つかない
  resources :users, only: [:index, :show, :create] do
    member do
      get :followings
      get :followers
      get :likes
    end
    
    # collection do
      # get :search
    # end
  end 
  
  resources :microposts, only: [:create, :destroy] 
  # フォローとリムーブだけルーティングを追加する
  resources :relationships, only: [:create, :destroy]
  # お気に入り登録とお気に入り解除を追加
  resources :favorites, only: [:create, :destroy]
end
