class ToppagesController < ApplicationController
  
  def index
    
    if logged_in?
      # Micropostの一覧はユーザに紐付くため、TOPpageのindexアクションに追加
      #form_with用
      @micropost = current_user.microposts.build
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
    end
    
  end
  
end
