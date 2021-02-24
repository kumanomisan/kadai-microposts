Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # 'コントローラ名#アクション名'
  # ということはtopppagesコントローラと対応するindexアクション(toppages/index.html.erb)の作成が必要
  root to: "toppages#index"
  
  # 新規登録URLを/signupにするため設定
  # resources :users で生成される URL である /users/new は少し格好悪く思えます。
  # そんなときには get 'signup' のように個別に設定することで解決します。とのこと
  get "signup", to: "users#new"
  
  #必要なアクションだけを設定している
  resources :users, only: [:index, :show, :create]
end
