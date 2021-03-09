class MicropostsController < ApplicationController
  
  #ユーザがログインしていることが前提のため、チェックする
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      flash[:success] = "メッセージを投稿しました。"
      redirect_to root_url
    else
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = "メッセージの投稿に失敗しました。"
      render "toppages/index"
    end
  end
  
  #before_action有
  def destroy
    @micropost.destroy
    flash[:success] = "メッセージを削除しました。"
    #redirect_back は、このアクションが実行されたページに戻るメソッド
    # fallback_location: root_path は、戻るべきページがない場合には root_path に戻る
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  #strongparameter
  def micropost_params
    params.require(:micropost).permit(:content)
  end 
  
  #そのmicropostが操作している人の物かどうかを調べたい
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    
    unless @micropost
      redirect_to root_url
    end
  end
  
end
