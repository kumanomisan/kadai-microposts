class FavoritesController < ApplicationController
  
  before_action :require_user_logged_in
  
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.register_favorite(micropost)
    flash.now[:success] = 'お気に入りに追加しました'
    redirect_to favorite_posts_user_path(current_user)
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.release_favorite(micropost)
    flash[:success] = 'お気に入りから削除しました'
    redirect_to favorite_posts_user_path(current_user)
  end

  
end
