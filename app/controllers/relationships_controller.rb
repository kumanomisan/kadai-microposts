class RelationshipsController < ApplicationController
  
  # 常にログイン状態を担保させる
  before_action :require_user_logged_in
  
  def create
    # フォローするuserのidをキーにユーザモデルから探す
    user = User.find(params[:follow_id])
    # 自身がフォロー（ユーザモデルクラスのメソッド）を使ってuserをフォロー
    current_user.follow(user)
    flash[:success] = "ユーザをフォローしました"
    # フォローしたユーザのページへ遷移
    redirect_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = "ユーザのフォローを解除しました"
    redirect_to user
  end
end
