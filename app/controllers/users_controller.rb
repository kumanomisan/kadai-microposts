class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :followings, :followers, :favorite_posts]
  #ログインしていないユーザにindexとshowのViewを見せないため
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    #ユーザー一覧をID降順に並び替え、ページネーション設定25にして表示
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
    
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favorite_posts
    @favorites_post = @user.favorite_microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  private
  
  #Before_action
  def set_user
    @user = User.find(params[:id])
  end
  
  #Strong_parameter
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
