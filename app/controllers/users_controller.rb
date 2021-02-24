class UsersController < ApplicationController
  
  before_action :set_user, only: [:show]
  
  def index
    #ユーザー一覧をID降順に並び替え、ページネーション設定25にして表示
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
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