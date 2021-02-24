Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # 'コントローラ名#アクション名'
  # ということはtopppagesコントローラと対応するindexアクション(toppages/index.html.erb)の作成が必要
  root to: "toppages#index"
end
