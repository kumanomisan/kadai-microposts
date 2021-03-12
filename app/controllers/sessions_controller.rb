class SessionsController < ApplicationController
  
  def new
  end

  def create
    
    # paramsからハッシュデータを取り出し、
    # さらにその中からハッシュデータの値を取り出している
    email = params[:session][:email].downcase
    password = params[:session][:password]

    # 現在のユーザーがログインしているかどうかを判別するメソッドです。
    if login(email, password)
      flash[:success] = "ログインに成功しました。"
      # @userの生成URL: prefix:user(@userインスタンス変数から idを取得してshow)
      redirect_to @user
    else
      flash.now[:danger] = "ログインに失敗しました。"
      # sessions/new.html.erbを表示
      render :new
    end
    
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  private
  
  def login(email,password)
    
    #emailをキーにしてSQL: WHERE: email = user.email
    # 仮に見つからない場合は:nilが返されるのでfalseとなる
    @user = User.find_by(email: email)
    
    #@userのパスワードが正しいかどうかをauthenticateで確認する
    if @user && @user.authenticate(password)
      # ログイン成功
      #ここでブラウザにCookieとして サーバにはSessionとして情報保持
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  
  end
  
end
